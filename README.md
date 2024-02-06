# diffusers-docker-with-jupyter

This Docker image is tailored for integration with [Paperspace Gradient notebooks](https://docs.paperspace.com/gradient/notebooks/), providing a ready-to-use environment that combines Hugging Face's Diffusers library with PyTorch and CUDA, optimized for JupyterLab. The base of this image is derived from the official [Hugging Face Diffusers Dockerfile](https://github.com/huggingface/diffusers/blob/main/docker/diffusers-pytorch-cuda/Dockerfile), enhanced with additional libraries to meet the requirements of Paperspace Gradient notebooks.

## Features

- **Pre-installed JupyterLab:** Facilitates an interactive development environment for machine learning and deep learning projects.
- **Optimized for Gradient:** Custom modifications ensure full compatibility and performance on Paperspace Gradient.
- **Automatic Updates:** Leveraging GitHub Actions for continuous integration, the Docker image is automatically built and pushed to Docker Hub upon updates.

## Dockerfile Modifications

The Dockerfile is a modified version of the Hugging Face Diffusers Dockerfile, with additional layers to include JupyterLab and other dependencies necessary for a comprehensive development environment on Paperspace Gradient.

### Modification Script

The `modify_dockerfile.sh` script is responsible for automating the enhancement process. It fetches the latest version of the Hugging Face Diffusers Dockerfile and appends instructions to install the required packages.

### Contributing to the Dockerfile

We encourage contributions to the Dockerfile to improve and update its functionality. To contribute:

1. Fork the repository containing our modified Dockerfile.
2. Make your changes and commit them to your fork.
3. Submit a pull request with a detailed explanation of your modifications and the benefits they provide.

Please ensure your contributions adhere to best practices for Dockerfile development and are compatible with Paperspace Gradient and the Hugging Face Diffusers library.

## GitHub Actions for CI/CD

The Docker image is automatically built and pushed to Docker Hub using GitHub Actions whenever changes are made to the repository. This CI/CD pipeline ensures the Docker image remains up-to-date and ready for deployment.

Docker Hub Repository: [masaishi2001/diffusers-docker-with-jupyter](https://hub.docker.com/repository/docker/masaishi2001/diffusers-docker-with-jupyter/general)

## Using the Docker Image

To deploy this Docker image within Paperspace Gradient notebooks:

1. Create or configure a Gradient notebook.
2. Specify `masaishi2001/diffusers-docker-with-jupyter` as the container image.

This setup provides you with a powerful environment for developing, training, and deploying machine learning models using Hugging Face's Diffusers library.
