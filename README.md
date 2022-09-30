# Terraform Google Cloud Docker

This repository includes a Dockerfile that installs and configures Terraform and Google Cloud SDK so you can run commands on a container. This is particularly useful if you can't find an ideally qualified DevOps Engineer or Cloud Architect and you have to move one of your developers to an Ops role. Not only does this reduce the time spent overcoming the learning curve by automating much of the setup process; but it thoroughly describes everything so they can go back and drill down later to gain a better understanding. Fully understanding the content of this repository (including the docker setup) can lead to some pretty amazing infrastructure automation capabilities down the road. I'll let it speak for itself, but I can do this all day.

## Requirements
- Docker
- Docker Compose
- Google Cloud account
- GCP authentication json file

## Building Your Setup

### Authenticating With GCP

If you do not have a service account for your project, review this documentation on how to create and manage service accounts. https://cloud.google.com/iam/docs/creating-managing-service-accounts. Once you have a service account with the necessary permissions, use a key to authenticate.

Note: Google recommends that we update this setup to instead use Workload Identity Federation https://cloud.google.com/iam/docs/workload-identity-federation?_ga=2.196205487.-221902407.1664555911. As of this writing, we're still using keys.

- From the GCP console, go to IAM & Admin -> Service Accounts. 
- Select your service account. Then select the KEYS tab.
- Click on the ADD KEY drop list and then select Create new key
- Make sure JSON is selected and click CREATE
- Once the file is downloaded, move it into your project root and rename it using the convention `myprojectname-auth.json`. This will ensure that the sensitive contents of this file will not be committed to source control.

### Local Config
- Copy the .env.example file over to .env and adjust the variable values accordingly. At the time of this writing, the only one is TF_VAR_project. 
- Make sure the TF_VAR_project value matches the project name in google cloud as well as the name of your authentication json.

## Commands

### General

Build the docker image with Terraform and Google Cloud SDK installed and copy the TF modules over.

`docker-compose build`

Useful in case you need to jump into the container and run commands directly for experimentation.

`docker-compose run gcloud /bin/bash`

### Terraform 

Most of these commands are just wrappers for common TF commands.

View any changes to the infrastructure that will be affected by applying code changes to your TF modules.

`docker-compose run gcloud terraform plan`


Apply changes to your terraform modules.

`docker-compose run gcloud terraform apply`
