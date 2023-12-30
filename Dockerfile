FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu22.04 as enfugue

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    SHELL=/bin/bash \
    ENFUGUE_SERVER_PORT=3001 \
    ENFUGUE_SERVER_DOMAIN=localhost \
    ENFUGUE_SERVER_SECURE=false \
    ENFUGUE_SERVER_NOAUTH=true \
    ENFUGUE_ROOT=/Enfugue \
    ENFUGUE_SERVER_ROOT=/Enfugue

WORKDIR /

# Install Ubuntu packages
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        python3.10 \
        python3.10-venv \
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
        libopencv-dev \
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
    ln -s /usr/bin/python3.10 /usr/bin/python && \
    python3 -m venv /venv && \
    source /venv/bin/activate && \
    pip install --upgrade pip && \
    pip install --upgrade setuptools && \
    pip install --upgrade wheel && \
    pip install nvidia-pyindex && \
    mkdir /Enfugue && \
    cd /Enfugue && \
    pip install enfugue[tensorrt] && \
    # curl https://raw.githubusercontent.com/painebenjamin/app.enfugue.ai/main/enfugue.sh -o enfugue.sh && \
    # chmod u+x enfugue.sh && \
    #./enfugue.sh --portable --update --mmpose && \   
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
    rm -f /etc/ssh/ssh_host_*
    
# NGINX Proxy
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/502.html /usr/share/nginx/html/502.html

# Copy the scripts
COPY --chmod=755 scripts/* ./
#COPY --chmod=755 config.yml /config.yml

# Start the container
SHELL ["/bin/bash", "--login", "-c"]
CMD [ "/start.sh" ]