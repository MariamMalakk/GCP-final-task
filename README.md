# GCP-final-task
Hosting a simple web app via private gke using terraform. 
__________________________________________________________________________________________________________________________
### Overview 
This project is to dockerize a web app and deploy it on a private cluster via private vm for more security. Infrastructure is created by terraform.
#### It consists of:
- VPC
- two private subnets (management-subnet & restricted-subnet)
- private VM to connect to cluster
- priviae cluster to deploy our app
- NAT Gateway 
___________________________________________________________________________________________________________________________
### Prerequisites:
  - linux
  - Terraform 
  - GCP
  - Docker
  - VScode
 ___________________________________________________________________________________________________________________________
 ### Login to your project on GCP:
 ```bash 
 gcloud auth login
 ```
____________________________________________________________________________________________________________________________
### Build GCP infrastructure:
- By using terraform files 
- Apply this commands on VScode
```bash
  cd terraform
  terraform init
  terraform plan
  terraform apply
```
_____________________________________________________________________________________________________________________________
### Connect to GCP private Cluster:
#### Note: kubectl is already installed as startup script in terraform, check instance.tf file.
- SSH to private VM 
- Then connect to the cluster from instance-1

![8-connect to cluster from vm](https://user-images.githubusercontent.com/118521640/220220562-c792dd41-57cb-415b-8407-36ed4c0b13c2.png)
____________________________________________________________________________________________________________________________
### Dockerize our app and push it on GCR:

```bash

gcloud auth configure-docker
docker build -t gcr.io/<project-id>/python-img .
docker push gcr.io/<project-id>/python-img
```
![10-push python img to gcr](https://user-images.githubusercontent.com/118521640/220222427-f47513fc-ceb4-40b5-a512-9fe91c8d60df.png)


### Push redis image to GCR:
```bash
docker pull redis
docker -t gcr.io/<project-id>/redis1
docker push gcr.io/<project-id>/redis1
```
![11-gcr images](https://user-images.githubusercontent.com/118521640/220222543-daa89cc0-a8df-4b88-8e1f-b7296528f9c2.png)

_____________________________________________________________________________________________________________________________

### Create Yaml files with two images and apply them to deploy our app.
#### Note: you can copy them from yml files directory.
![12-deployments](https://user-images.githubusercontent.com/118521640/220224140-0c15015c-607f-43a1-b586-244349450404.png)

![13-pods created](https://user-images.githubusercontent.com/118521640/220224249-1d4935be-a1f5-46be-b362-a3c8dc0140ee.png)

______________________________________________________________________________________________________________________________

### Check our app:
#### Once you hit external IP for loadbalacer and port 8000 you will check our app 
![14-hit lb port](https://user-images.githubusercontent.com/118521640/220224722-cea45ea2-d9ae-4b7e-979b-356798facc4c.png)


![15-lb on console](https://user-images.githubusercontent.com/118521640/220224776-7fb5b9dc-aa80-4676-934d-8d0fff08cfba.png)

_______________________________________________________________________________________________________________________________
### Cluster details:
![priv-cluster](https://user-images.githubusercontent.com/118521640/220224877-a308c759-6e81-4f50-bf48-85c5e5476207.png)


![cont  priv-cluster](https://user-images.githubusercontent.com/118521640/220224895-1d6f6038-6a84-45ea-b76b-ebad022a03fa.png)

_______________________________________________________________________________________________________________________________
### Network preferences:
- Creating VPC and subnets
![1-vpc](https://user-images.githubusercontent.com/118521640/220225381-e03c7369-41af-4023-bcfa-7a11a3aa4a80.png)

![2-subnets](https://user-images.githubusercontent.com/118521640/220225475-d990ee50-0c82-417f-8f57-31d990c8a301.png)

- Creating private VM
 ![3-private vm](https://user-images.githubusercontent.com/118521640/220225599-10ca2c4e-dc8e-4631-8799-ca7c201f555f.png)
 
- Creating NAT gateway
![5-nat specs](https://user-images.githubusercontent.com/118521640/220225649-c864ce98-c815-4b77-b8ba-2cc925f719ee.png)


