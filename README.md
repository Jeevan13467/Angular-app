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

Access the website: use public IP address of the server


## Install Docker

```
sudo apt install docker.io
```
create a Dockerfile according to the project 
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

### Install Kubectl for application deployment 
```
sudo snap install kubectl --classic
```

```
