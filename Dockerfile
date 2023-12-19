# Build:
# docker build --platform=linux/amd64 . -t docker-ml-runpod
# Push:
# docker tag docker-ml-runpod:latest ankurio/docker-ml-runpod:latest
# docker push ankurio/docker-ml-runpod:latest

# FROM ghcr.io/ankur-gupta/docker-ml-base:main
FROM ankurio/docker-ml-base:latest

USER root

# We want to allow public key SSH authentication only
COPY sshd_config /etc/ssh/sshd_config

# Expose ports for Jupyter and SSH
EXPOSE 8888
EXPOSE 22

# Set the default command for the container
COPY start.sh /start.sh
CMD [ "/start.sh"]
