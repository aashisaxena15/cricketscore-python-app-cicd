pipeline {
    agent any 
    environment {
        DOCKER_USERNAME = "aashisaxena15"
        APP_NAME = "flask-app"
        IMAGE_TAG = "${BUILD_NUMBER}"
        IMAGE_NAME = "${DOCKER_USERNAME}/${APP_NAME}"
    }
    
    stages {
        stage("Clean up the workspace") {
            steps {
                cleanWs()
            }
        }

        stage("Checkout Git SCM") {
            steps {
                git branch: 'main', url: 'https://github.com/aashisaxena15/cricketscore-python-app-cicd.git'
            }
        }

        stage("Build Docker Image") {
            steps {
                sh "sudo docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage("Push to Docker Hub") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-cred', passwordVariable: 'pass', usernameVariable: 'user')]) {
                    sh """
                        sudo docker login -u ${user} -p ${pass}
                        sudo docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }

        stage("Delete Local Docker Image") {
            steps {
                sh "sudo docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage("Update the Deployment File in CD") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github-cred', passwordVariable: 'pass', usernameVariable: 'user')]) {
                        sh """
                            git clone https://${user}:${pass}@github.com/aashisaxena15/flask-app-CD.git
                            cd flask-app-CD

                            echo "Before change:"
                            cat deployment.yaml

                            echo "Changing image tag to ${IMAGE_TAG}"
                            sed -i 's|image: aashisaxena15/flask-app:.*|image: ${IMAGE_NAME}:${IMAGE_TAG}|g' deployment.yaml

                            echo "After change:"
                            cat deployment.yaml

                            git config user.email "ci@example.com"
                            git config user.name "ci-bot"

                            git add deployment.yaml
                            git commit -m "Updated the tag to ${IMAGE_TAG}"
                            git push origin main
                        """
                    }
                }
            }
        }
    }
}
