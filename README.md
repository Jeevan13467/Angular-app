# Angular-app
## AWS EC2 Instance

- Go to AWS Console
- Instances(running)
- Launch instances

Pre-Requisites:
- Install nodejs 
- Install angular cli

### Run the below commands to install nodejs  and Angular cli

Install Nodejs 

```
sudo apt update
sudo apt install -y nodejs npm
```
check version 
```
node -v
npm -v
```
Install Nodejs 
```
sudo npm install -g @angular/cli
```

Create a New Angular Project
```
ng new my-angular-app
```

Install Nginx 
```
sudo apt install nginx
systemctl enable nginx
systemctl run nginx
```
Access to newly created Angular file 

```
cd <newly created angular project name>
```
save the html and css file in the angular project 
```
https://github.com/Jeevan13467/Angular-app/blob/main/index.html
```
```
https://github.com/Jeevan13467/Angular-app/blob/main/styles.css
```

Access the website: use public IP address of the server


## Install Docker

```
sudo apt install docker.io
```
create a Dockerfile according to the project 
```
https://github.com/Jeevan13467/Angular-app/blob/main/Dockerfile
```
-Build Docker Image
```
 docker build -t <Angular project name>
 ```
Run the docker file using the port number 
```
docker run -d -p 8080:80 <Angular project name>
```
check the Docker Images is created or not 
```
docker images
```

### Install Kubectl for application deployment and minikube
```
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```
To deploy the application we used  
```
https://github.com/Jeevan13467/Angular-app/blob/main/angular-web-deployment.yaml
```

To provide stable, load-balanced access to those Pods.
```
https://github.com/Jeevan13467/Angular-app/blob/main/angular-web-service.yaml
```

check minikube version 
```
minikube --version
```
create a minicube file and add syntax according to the application 

```
minikube start
kubectl cluster-info
```
check the Public IP address of minikube pod 
```
minikube start
kubectl cluster-info
```
access the application using the IP Address and the port that was mentioned in the minikube file 

## Crontab and cronjob for system health checks

Create a file to save the health check syntax and the file name should be <file name.sh>
```
https://github.com/Jeevan13467/Angular-app/blob/main/healthcheck.sh
```
Run cronjob using 
```
crontab -e
```
select Nano edition --preferable 

schedule the cronjob time for healthchecks 

How to view healthcheck html file 
-go to root user 
-check the files with 'ls '
-you will get a file <your healthcheck file.html>
you can download the file to view the server health.

