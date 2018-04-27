FROM docker:stable-dind

RUN adduser user -D -g ""

ENV DM_VERSION v0.12.2
ENV DM_URL https://github.com/docker/machine/releases/download/$DM_VERSION/docker-machine-Linux-x86_64

RUN apk add --no-cache \
	curl \
	py-pip \
	bash \
	git \
	vim \
	sudo \
	expect \
	shadow \
	rsync \
	nano \
	joe \
	less \
	util-linux \
	ncurses \
	openssh-client \
	bind-tools \
    && curl -L $DM_URL > /usr/bin/docker-machine \
    && chmod +x /usr/bin/docker-machine \
    && pip install docker-compose

RUN echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > /etc/ssh/ssh_config

RUN curl -s https://raw.githubusercontent.com/adlogix/docker-machine-nfs/master/docker-machine-nfs.sh | \
  sudo tee /usr/local/bin/docker-machine-nfs > /dev/null && \
  sudo chmod +x /usr/local/bin/docker-machine-nfs

RUN apk del --purge curl && \
    rm -rf /var/cache/apk/* /lib/apk/db/*

RUN echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
	chmod 0440 /etc/sudoers.d/user
