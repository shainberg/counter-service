from kubernetes import client, config
import json
import time


class ConfigMapUpdater:
    JSON_FILE_NAME: str = "counter.json"

    def __init__(self, namespace, configmap_name, max_retries=5, retry_interval=2):
        self.namespace = namespace
        self.configmap_name = configmap_name
        self.max_retries = max_retries
        self.retry_interval = retry_interval
        self.v1 = client.CoreV1Api()
        self.load_kubernetes_config()

    @staticmethod
    def load_kubernetes_config():
        """Load Kubernetes configuration."""
        config.load_incluster_config()

    def get_configmap(self):
        """Retrieve the ConfigMap from the specified namespace."""
        return self.v1.read_namespaced_config_map(self.configmap_name, self.namespace)

    def parse_data(self,):
        configmap = self.get_configmap()
        """Parse and return the counter data from the ConfigMap."""
        data = configmap.data[self.JSON_FILE_NAME]
        return json.loads(data)

    @staticmethod
    def update_counter_data(json_data):
        """Update the counter and lock values in the JSON data."""
        json_data['counter'] += 1
        return json_data

    def update_configmap_data(self, json_data):
        """Update the ConfigMap with new data."""
        configmap = self.v1.read_namespaced_config_map(self.configmap_name, self.namespace)
        configmap.data[self.JSON_FILE_NAME] = json.dumps(json_data)
        self.v1.replace_namespaced_config_map(self.configmap_name, self.namespace, configmap)
        print("ConfigMap updated successfully.")

    def try_update_configmap(self, json_data):
        """Attempt to update the ConfigMap with new data."""
        configmap = self.get_configmap()
        configmap.data['counter.json'] = json.dumps(json_data)
        try:
            self.v1.replace_namespaced_config_map(self.configmap_name, self.namespace, configmap)
            return True
        except client.exceptions.ApiException as e:
            if e.status == 409:  # Conflict error, indicating a version mismatch
                return False
            raise

    def update_configmap(self):
        """Main method to update the ConfigMap."""
        for attempt in range(self.max_retries):
            json_data = self.parse_data()
            updated_data = self.update_counter_data(json_data)

            if self.try_update_configmap(updated_data):
                print("ConfigMap updated successfully.")
                return
            else:
                print(f"Conflict detected. Retrying in {self.retry_interval} seconds...")
                time.sleep(self.retry_interval)

        print("Failed to update ConfigMap after multiple attempts.")
