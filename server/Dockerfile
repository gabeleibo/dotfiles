#=====================================================
#===================== Base OS =======================
#=====================================================
FROM ubuntu:18.10
ENV DEBIAN_FRONTEND=noninteractive

#=====================================================
#=================== Dependencies ====================
#=====================================================

RUN apt-get update -qq && apt-get upgrade -y && apt-get install -qq -y \
	curl \
	docker.io \
	git \
	git-crypt \
	locales \
	mosh \
  nodejs \
  npm \
	openssh-server \
	python \
	python3 \
	python3-pip \
	python3-setuptools \
	python3-venv \
	python3-wheel \
	tmux \
	unzip \
	wget \
	zip \
	zsh \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

#=====================================================
#====================== Config =======================
#=====================================================

RUN mkdir /run/sshd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed 's/#Port 22/Port 3222/' -i /etc/ssh/sshd_config

RUN mkdir ~/.ssh && curl -fsL https://s3.amazonaws.com/gabeleibo-public-keys/ssh.keys > ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys

ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
	locale-gen --purge $LANG && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=$LANG LC_ALL=$LC_ALL LANGUAGE=$LANGUAGE

RUN pip3 install docker-compose

# for correct colours is tmux
ENV TERM screen-256color

EXPOSE 3222

WORKDIR /root
COPY entrypoint.sh /bin/entrypoint.sh

CMD ["/bin/entrypoint.sh"]
