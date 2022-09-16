ARG HOST_USER_UID=1001
ARG HOST_USER_GID=1001

FROM ubuntu

ARG HOST_USER_UID
ARG HOST_USER_GID

RUN apt-get update && \
    apt-get install -y curl \
                        apt-transport-https \
                        ca-certificates \
                        gnupg


# Install Google Cloud SDK
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install google-cloud-cli

WORKDIR /app

RUN addgroup --gid $HOST_USER_GID dev && \
    adduser --system --no-create-home --uid $HOST_USER_UID --gid $HOST_USER_GID --disabled-password --gecos "" dev

COPY . .

# Install Terraform
RUN apt-get update -y
RUN apt-get install -y gnupg software-properties-common curl
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get install terraform

# RUN chown -R dev:dev /app

# USER dev

# CMD ["/bin/bash"]
