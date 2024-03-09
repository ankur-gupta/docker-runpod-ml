# Build:
# docker build --platform=linux/amd64 . -t docker-runpod-ml
# Push:
# docker tag docker-runpod-ml:latest ghcr.io/ankur-gupta/docker-runpod-ml:latest
# docker push ghcr.io/ankur-gupta/docker-runpod-ml:latest

FROM ghcr.io/ankur-gupta/docker-base-ml:latest

USER root

# Create workspace directory (default for mounting runpod volumes)
RUN mkdir /workspace

# We want to allow public key SSH authentication only
COPY sshd_config /etc/ssh/sshd_config

# Expose ports for Jupyter and SSH
EXPOSE 8888
EXPOSE 22

# Set the default command for the container
COPY start.sh /start.sh
CMD [ "/start.sh"]
