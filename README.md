
#### Assignment
Automate your application's CI/CD pipeline with Jenkins, Helm and Kubernetes. Make sure you use Jenkins credentials, environment variables in the pipeline.  

1. Prepare SCM repository for your application
2. Developer pushes code to Git, which triggers a Jenkins build webhook. Jenkins pulls the latest code changes.
3. Build the application's Docker image and push to Docker registry (You get one private repository for free with your Docker Hub user account).
4. Deploys application on your local Kubernetes cluster to different environments dev, QA, staging & Production using the Helm chart from the repo.
5. Verify the deployed application is up and running. 

_Note:_ Assignment should be done through automated pipeline only.


#### Solution:
1. Using this Repository as SCM Repository which contains Application code, Dockerfile, Helm Chart and Jenkinsfile for this Jenkins Ci/CD Pipeline
2. As per above mentioned assignment, created a automated pipeline script in Jenkinsfile and following below steps for Implementation of Pipeline
3. Goto **Jenkins Dashboard**, Click on **New Item** and then Select **Pipeline** Project.
4. Under **Build Trigger**, Enable **GitHub hook trigger for GITScm polling** 
5. Under Pipeline **Defination**, Select **Pipeline script from SCM** and then Select SCM as Git and then add Repo URL & Jenkinsfile name and Save.
6. Add Docker Repo Credentials and SSH private Key under Jenkins Credentials. Goto Manage Jenkins > Manage Credentials
7. Now in our Github Repo, Create a Webhook. Goto Setting > Webhooks > Add webhook.
8. Under Payload URL,add **your_jenkins_url/github-webhook/** and Select Content type as application/json and then Click on **Add Webhook**.
9. Make Sure neccessary plugins [Github,Pipeline,Docker,Email,SSHAgent,Kubernetes Continous Deploy, etc.,] are installed.
10. Now whenever the developer pushes the code to Git, then webhook triggers the build in Jenkins Automatically using the pipeline script from jenkins file.
