# Stage 1: Base
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04 as base

ARG ANYDOOR_VERSION=main

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=yes \
    SHELL=/bin/bash

WORKDIR /

# Install Ubuntu packages
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        python3.8 \
        python3.8-venv \
        python3-pip \
        python3-tk \
        nginx \
        bash \
        git git-lfs \
        ncdu \
        net-tools \
        openssh-server \
        libglib2.0-0 \
        libsm6 \
        libgl1 \
        libxrender1 \
        libxext6 \
        ffmpeg \
        wget \
        curl \
        psmisc \
        rsync \
        vim \
        nano \
        zip \
        unzip \
        htop \
        pkg-config \
        libcairo2-dev \
        libgoogle-perftools4 libtcmalloc-minimal4 \
        apt-transport-https ca-certificates && \
    update-ca-certificates && \
    apt-get clean && \
    git lfs install && \
    rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    ln -s /usr/bin/python3.8 /usr/bin/python && \
    python3 -m venv /venv && \
    git clone -b ${ANYDOOR_VERSION} https://github.com/damo-vilab/AnyDoor.git && \
    cd /AnyDoor && \
    source /venv/bin/activate && \
    pip3 install -r requirements.txt && \
    pip install git+https://github.com/cocodataset/panopticapi.git && \
    pip install pycocotools -i https://pypi.douban.com/simple && \
    pip install lvis && \
    deactivate && \
    cd / && \
    pip3 install -U --no-cache-dir jupyterlab \
        jupyterlab_widgets \
        ipykernel \
        ipywidgets \
        gdown && \
    wget https://github.com/runpod/runpodctl/releases/download/v1.10.0/runpodctl-linux-amd -O runpodctl && \
    chmod a+x runpodctl && \
    mv runpodctl /usr/local/bin && \
    rm -f /etc/ssh/ssh_host_* && \
    mkdir /AnyDoor/path && \
    wget -O /AnyDoor/path/epoch=1-step=8687.ckpt https://huggingface.co/spaces/xichenhku/AnyDoor/resolve/main/epoch%3D1-step%3D8687.ckpt?download=true && \
    wget -O /AnyDoor/path/dinov2_vitg14_pretrain.pth https://dl.fbaipublicfiles.com/dinov2/dinov2_vitg14/dinov2_vitg14_reg4_pretrain.pth
    
# NGINX Proxy
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/502.html /usr/share/nginx/html/502.html

# Copy the scripts
COPY --chmod=755 scripts/* ./

# Start the container
SHELL ["/bin/bash", "--login", "-c"]
CMD [ "/start.sh" ]