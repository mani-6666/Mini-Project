pipeline { 
    agent any 
 
    stages { 
        stage('Checkout') { 
            steps { 
                git branch: 'main', url: 'https://github.com/mani-6666/Mini-Project.git'
            } 
        } 
 
        stage('Build Docker Image') { 
            steps { 
                script { 
                    sh 'docker build -t react-express-app .' 
                } 
            } 
        } 
 
        stage('Run Container') { 
            steps { 
                script { 
                    // Stop old container if running 
                    sh 'docker ps -q --filter "name=react-express-app" | grep -q . && docker stop react-express-app && docker rm react-express-app || true' 
                    // Start new container 
                    sh 'docker run -d -p 5000:5000 --name react-express-app react-express-app' 
                } 
            } 
        } 
    } 
 
    post { 
        success { 
            echo " Deployment completed successfully!" 
        } 
        failure { 
            echo " Build or deployment failed!" 
        } 
    } 
}