pipeline{
    agent { label "dev" }
    
    stages{
        stage("Code Clone"){
            steps{
                echo "Code Cloning Start....."
                git url: "https://github.com/anurag1352/Springboot-BankApp.git", branch: "DevOps"
                echo "Code Cloning Done...."
            }
        }
        stage("Build Image"){
            steps{
                echo "Image Build Start..."
                sh "docker build -t springboot-bankapp ."
                echo "Image Build Successful....."
            }
        }
        stage("Code Testing"){
            steps{
                echo "Testing Start..."
                echo "Testing Complete...."
            }
        }
        stage("Scan image & files"){
            steps{
                sh "trivy fs . -o results.json"
            }
        }
        stage("Push To DockerHub"){
            steps{
                withCredentials([usernamePassword(credentialsId: "dockerHubCreds", passwordVariable: "dockerHubPass", usernameVariable: "dockerHubUser")]){
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    sh "docker image tag springboot-bankapp:latest ${env.dockerHubUser}/springboot-bankapp:latest"
                    sh "docker push ${env.dockerHubUser}/springboot-bankapp:latest"
                }
            }
        }
        stage("Code Deploy"){
            steps{
                echo "Deployment Start..."
                sh "docker-compose down && docker-compose up -d"
                echo "Deployment Done....."
            }
        }
    }
}
