def DAY_TO_KEEP_STR = '14'

def NUM_TO_KEEP_STR = '42'

pipeline{
    agent any
    options{
        buildDiscarder(logRotator(daysToKeepStr: DAY_TO_KEEP_STR, numToKeepStr: NUM_TO_KEEP_STR))
        timestamps()
    }
    environment {
        version = 'latest'
        registry = '630943284793.dkr.ecr.us-west-1.amazonaws.com/counter-service'
        registryCredential = 'aws-creds'
        dockerImage = ''
    }
    stages{
        stage('Build Image'){
            steps{
                script {
                    sh 'sudo gpasswd -a $USER docker'
                    dockerImage = docker.build registry + ":latest"
                }
            }
        }
        stage('Publish image') {
            steps{
                script{
                    docker.withRegistry("https://" + registry, "ecr:us-west-1:" + registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
//    post {
//        always {
//
//        }
//        success{
//
//        }
//        failure{
//
//        }
//    }
}
