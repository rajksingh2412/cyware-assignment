pipeline {
    agent any 
    stages {
        stage('git-stage') { 
            steps {
                echo "This is Git COnfig stage."
                sh 'git clone xyz'
            }
        }
        stage('Install') { 
            steps {
                echo "This is Install stage." 
                sh 'sudo apt install docker -y'
                sh 'sudo apt install docker-compose -y'
            }
        }
        stage('Deploy') { 
            steps {
                echo "This is Deploy stage." 
                sh 'cd cyware'
                sh 'docker-compose up'
            }
        }
    }
}