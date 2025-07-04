pipeline {
    agent {
        label any
    }
    tools {
        maven 'maven3.9.9'
    }
    stages {
        stage('Code Checkout') {
            steps {
                git branch: 'main', credentialsId: 'git_repo_2', url: 'https://github.com/keamysh/docker_local.git'
            }
        }
        stage('Package Code Artifacts') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'whoami'
                sh 'docker build -t keamysh/tomcat:${BUILD_NUMBER} .'
                sh 'docker tag keamysh/tomcat:${BUILD_NUMBER} keamysh/tomcat:latest'
            }
        }
        stage('Push Image to Repo') {
            steps{
                withCredentials([usernamePassword(credentialsId: 'docker_hub_cred', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
                    sh 'docker push keamysh/tomcat:latest'
                }
            }
        }
        stage('Run Containers') {
            steps{
                sshagent(['agent_private_key']) {

                    sh 'scp load_config/haproxy.cfg deploy.sh ami@192.168.2.141:/opt/docker_config_files/'
                    sh 'ssh ami@192.168.44.167 "bash /opt/docker_config_files/deploy.sh"'
                }
            }
        }
        stage('Deploy to Tomcat') {

            steps{
                deploy adapters: [tomcat9(credentialsId: 'tomcat_password', path: '', url: 'http://192.168.44.167:8081')], contextPath: 'web-app', war: 'target/*.war'
                deploy adapters: [tomcat9(credentialsId: 'tomcat_password', path: '', url: 'http://192.168.44.167:8082')], contextPath: 'web-app', war: 'target/*.war'
                deploy adapters: [tomcat9(credentialsId: 'tomcat_password', path: '', url: 'http://192.168.44.167:8083')], contextPath: 'web-app', war: 'target/*.war'
                deploy adapters: [tomcat9(credentialsId: 'tomcat_password', path: '', url: 'http://192.168.44.167:8084')], contextPath: 'web-app', war: 'target/*.war'
                deploy adapters: [tomcat9(credentialsId: 'tomcat_password', path: '', url: 'http://192.168.44.167:8085')], contextPath: 'web-app', war: 'target/*.war'
                deploy adapters: [tomcat9(credentialsId: 'tomcat_password', path: '', url: 'http://192.168.44.167:8086')], contextPath: 'web-app', war: 'target/*.war'
            }
        }
    }
}

