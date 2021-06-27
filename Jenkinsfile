def DAY_TO_KEEP_STR = '14'

def NUM_TO_KEEP_STR = '42'

pipeline{
    agent {
        label 'linux-slave'
    }
    options{
        buildDiscarder(logRotator(daysToKeepStr: DAY_TO_KEEP_STR, numToKeepStr: NUM_TO_KEEP_STR))
        timestamps()
    }
    stages{
        stage('Build'){
            steps{
                script{
                    sh 'echo Hello'
                }
            }
        }
    }
    post {
        always {

        }
        success{

        }
        failure{

        }
    }
}