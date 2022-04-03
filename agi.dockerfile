FROM pytorch/pytorch:latest

# update
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -o Dpkg::Options::="--force-confold" dist-upgrade -q -y --force-yes

# add a new user
RUN useradd -ms /bin/bash hewei
RUN usermod -aG sudo hewei

# install new softwares
RUN apt-get -y install vim
RUN apt-get -y install sudo
RUN apt-get -y install git
RUN pip install notebook

# reset password
RUN echo 'hewei:hewei' | chpasswd

# build new environment
WORKDIR /home/hewei
USER hewei

EXPOSE 8000

# entrypoint
ENTRYPOINT [ "jupyter","notebook","--no-browser","--ip=0.0.0.0","--port=8000"]