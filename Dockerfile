ARG HOST_USER_UID=1001
ARG HOST_USER_GID=1001
ARG PYTHON_VERSION=3.7.5
ARG TERRAFORM_VERSION=1.3.1

FROM ubuntu

ARG HOST_USER_UID
ARG HOST_USER_GID
ARG PYTHON_VERSION
ARG TERRAFORM_VERSION

RUN apt-get update && \
    apt-get install -y curl \
                        apt-transport-https \
                        ca-certificates \
                        gnupg \
                        wget \
                        unzip 

# Install Python for Google Cloud SDK
RUN apt-get install -y python3 python3-pip

# Install Google Cloud SDK
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install google-cloud-cli

WORKDIR /app

# Add user and group so we can edit tf module files without permission errors.
RUN addgroup --gid $HOST_USER_GID dev && \
    adduser --system --no-create-home --uid $HOST_USER_UID --gid $HOST_USER_GID --disabled-password --gecos "" dev

# Copy Terraform Modules into Container
COPY . .

# Install Terraform from Source
# RUN apt-get install -y unzip wget
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN mv terraform /usr/local/bin/
RUN rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Fix the ownership of the tf modules files
RUN chown -R dev:dev /app

USER dev

# CMD ["/bin/bash"]
