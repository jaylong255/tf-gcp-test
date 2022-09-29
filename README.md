# Terraform Google Cloud Docker

This repository includes a Dockerfile that installs and configures Terraform and Google Cloud SDK so you can run commands on a container. This is particularly useful if you can't find an ideally qualified DevOps Engineer or Cloud Architect and you have to move one of your developers to an Ops role. Not only does this reduce the time spent overcoming the learning curve by automating much of the setup process; but it thoroughly describes everything so they can go back and drill down later to gain a better understanding. Fully understanding the content of this repository (including the docker setup) can lead to some pretty amazing infrastructure automation capabilities down the road. I'll let it speak for itself, but I can do this all day.

## Requirements
- Docker
- Docker Compose
- Google Cloud account
- GCP authentication json file

## Building Your Setup
- From the GCP console, generate an authentication json for your project. 
- Copy the .env.example file over to .env and adjust the variable values accordingly. At the time of this writing, the only one is TF_VAR_project. 

## Commands

### General

`docker-compose build`

Builds the docker image with Terraform and Google Cloud SDK installed and copies the TF modules over.

`docker-compose run gcloud /bin/bash`

Useful in case you need to jump into the container and run commands directly for experimentation.

### Terraform 

Most of these commands are just wrappers for common TF commands.

`docker-compose run gcloud terraform plan`

View any changes to the infrastructure that will be affected by applying code changes to your TF modules.

`docker-compose run gcloud terraform apply`

Apply changes to your terraform modules.