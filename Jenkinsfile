def DAY_TO_KEEP_STR = '14'

def NUM_TO_KEEP_STR = '42'

pipeline{
    agent {
        label 'jenkins-slave'
    }
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
                    dockerImage = docker.build registry
                }
            }
        }
        stage('Publish image') {
            steps{
                script{
                    docker.withRegistry("https://" + registry, "ecr:us-west-1:" + registryCredential) {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push('latest')
                    }
                }
            }
        }
        stage('Deploy image'){
            steps{
                script{
                    sh """
                        sed -i "s/630943284793.dkr.ecr.us-west-1.amazonaws.com/counter-service:*/630943284793.dkr.ecr.us-west-1.amazonaws.com/counter-service:${env.BUILD_NUMBER}/g" counter-service.yaml
                        cat counter-service.yaml
                        git add --all
                        git commit -m "Updated version to ${env.BUILD_NUMBER}"
                        git push origin $GIT_BRANCH
                    """
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
