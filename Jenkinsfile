pipeline {
    agent any
    tools {
        jdk 'jdk17'
        maven 'maven3'
    }
	environment {
      DOCKER_TAG = getVersion()
    }

    stages {
        stage('Clean WorkSpace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout SourCode') {
            steps {
                git branch: 'main', url: 'https://github.com/bcreddydevops/GA-DockerCICD.git'
            }
        }
        stage('Maven Package') {
            steps {
                sh 'mvn clean package'
            }
        }
		stage('Docker Build'){
            steps{
                sh "docker build . -t chinnareddaiah/my-app:${DOCKER_TAG}"
            }
        }
        stage('Docker Login and Docker Push') {
             steps {
                    withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                    sh "docker push chinnareddaiah/my-app:${DOCKER_TAG}"
                 }
                }
            }
        stage('Docker Deploy from ansible'){
            steps{
              ansiblePlaybook credentialsId: 'ssh', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'docker.yml'
            }
        }
     }
}
def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
