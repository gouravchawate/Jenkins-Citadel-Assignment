pipeline {
    agent any
    environment {
        MyRepo=credentials('mydetails')
        ImageName='mynginxapp'
        ImageTag='2.0'
        AppRelease='webapp-2'
    }
    stages {
        stage('GitClone') {
            steps {
                echo 'Getting Updated Source Code from Github'
                git branch: 'main', url: 'https://github.com/gouravchawate/Jenkins-Citadel-Assignment.git'
            }
        }
        stage('BuildImage') {
            steps {
                echo 'Building Docker Image'
                sh 'docker build -t $MyRepo_USR/$ImageName:$ImageTag .'
            }
        }
       stage('PushImageToRepo') {
            steps {
                echo 'Logging into Docker Repo'
                sh 'docker login --username $MyRepo_USR --password $MyRepo_PSW'
                echo 'Push to Repo'
                sh 'docker push $MyRepo_USR/$ImageName:$ImageTag'
                sh 'docker logout'
                sh 'docker rmi $MyRepo_USR/$ImageName:$ImageTag'
            }
        }
       stage('Deployment') {
            steps {
                sshagent(credentials: ['myssh']) {     
                    //sh 'scp -r -o StrictHostKeyChecking=no deploy.yml gourav@192.168.1.5:/tmp'
                    sh 'scp -r -o StrictHostKeyChecking=no webappchart/ gourav@192.168.1.5:/tmp/webappchart'
                    script{
                        try{
                            // sh 'ssh gourav@192.168.1.5 kubectl apply -f /tmp/deploy.yml'

                            // Deploy to Dev Environment
                            sh 'ssh gourav@192.168.1.5 helm upgrade --install $AppRelease /tmp/webappchart --set myapp.image=$MyRepo_USR/$ImageName:$ImageTag -n devenv --create-namespace'

                            // Deploy to QA Environment
                            sh 'ssh gourav@192.168.1.5 helm upgrade --install $AppRelease /tmp/webappchart --set myapp.image=$MyRepo_USR/$ImageName:$ImageTag -n qaenv --create-namespace'

                            // Deploy to Prod Environment
                            sh 'ssh gourav@192.168.1.5 helm upgrade --install $AppRelease /tmp/webappchart --set myapp.image=$MyRepo_USR/$ImageName:$ImageTag -n prodenv --create-namespace'
                        }
                        catch(error)
                        {
                            echo 'Deployment Error'
                        }
                    }
                }
            }
        }
     }
     
     post {
            success {
                mail bcc: '', body: '''Hey Admin,
                Your Build is successfull !!''', cc: '', from: '', replyTo: '', subject: 'Build Success', to: 'jktest@myapp.com'
            }
            failure {
                mail bcc: '', body: '''Hey Admin,
                Your Build is Failed !!''', cc: '', from: '', replyTo: '', subject: 'Build Failed', to: 'jktest@myapp.com'
            }
     }      
}
