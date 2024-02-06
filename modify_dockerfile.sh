#!/bin/bash

# URL of the Dockerfile
DOCKERFILE_DIFFUSERS_URL="https://raw.githubusercontent.com/huggingface/diffusers/main/docker/diffusers-pytorch-cuda/Dockerfile"

# Download the Dockerfile from the provided URL
curl -s "$DOCKERFILE_DIFFUSERS_URL" -o "DIFFUSERS"

# Verify download was successful
if [ ! -f "DIFFUSERS" ]; then
    echo "Failed to download Dockerfile from $DOCKERFILE_DIFFUSERS_URL."
    exit 1
fi

# Remove specific lines from DIFFUSERS
# Delete lines related to the python venv and CMD ["/bin/bash"]
sed -i '' '# make sure to use venv' "DIFFUSERS"
sed -i '' '/RUN python3 -m venv \/opt\/venv/d' "DIFFUSERS"
sed -i '' '/ENV PATH="\/opt\/venv\/bin:\$PATH"/d' "DIFFUSERS"
sed -i '' '/CMD \["\/bin\/bash"\]/d' "DIFFUSERS"

# Begin constructing the final Dockerfile
cat "DIFFUSERS" >> Dockerfile
echo "" >> Dockerfile

# Append additional instructions to the Dockerfile
cat >> Dockerfile <<'EOF'
# Set ENV variables
ENV LANG C.UTF-8
ENV SHELL=/bin/bash
ENV DEBIAN_FRONTEND=noninteractive

RUN rm -rf /opt/hostedtoolcache

#RUN apt-get update && apt-get install -y wget && \
#	apt-get clean && rm -rf /var/lib/apt/lists/*

## ==================================================================
## Installing CUDA packages (CUDA Toolkit 12.0 and CUDNN 8.9.7)
## ------------------------------------------------------------------
#RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin && \
#    mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
#    wget https://developer.download.nvidia.com/compute/cuda/12.0.0/local_installers/cuda-repo-ubuntu2204-12-0-local_12.0.0-525.60.13-1_amd64.deb && \
#    dpkg -i cuda-repo-ubuntu2204-12-0-local_12.0.0-525.60.13-1_amd64.deb && \
#    cp /var/cuda-repo-ubuntu2204-12-0-local/cuda-*-keyring.gpg /usr/share/keyrings/ && \
#    apt-get update && \
#    apt-get install -y cuda && \  
#    rm cuda-repo-ubuntu2204-12-0-local_12.0.0-525.60.13-1_amd64.deb && \
#	apt-get clean && rm -rf /var/lib/apt/lists/*

## Installing CUDNN
#RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub && \
#    add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /" && \
#    apt-get update && \
#    apt-get install -y libcudnn8=8.9.7.29-1+cuda12.2  \
#                     libcudnn8-dev=8.9.7.29-1+cuda12.2 && \
#	apt-get clean && rm -rf /var/lib/apt/lists/*

#ENV PATH=$PATH:/usr/local/cuda/bin
#ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

RUN python3 -m pip install --no-cache-dir jupyterlab jupyter_contrib_nbextensions jupyterlab-git

EXPOSE 8888 6006

CMD jupyter lab --allow-root --ip=0.0.0.0 --no-browser --ServerApp.trust_xheaders=True --ServerApp.disable_check_xsrf=False --ServerApp.allow_remote_access=True --ServerApp.allow_origin='*' --ServerApp.allow_credentials=True
EOF

echo "Dockerfile has been created successfully."
