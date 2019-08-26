#=====================================================
#================== Dependencies =====================
#=====================================================


#=====================================================
#===================== Base OS =======================
#=====================================================
FROM ubuntu:18.10
ENV DEBIAN_FRONTEND=noninteractive

#=====================================================
#=================== OS Dependencies =================
#=====================================================

RUN apt-get update -qq && apt-get upgrade -y && apt-get install -qq -y \
  build-essential \
	curl \
  cmake \
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
  python3-dev \
	python3-pip \
	python3-setuptools \
	python3-venv \
	python3-wheel \
	software-properties-common \
	tmux \
	unzip \
	wget \
	zip \
	zsh \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN pip3 install docker-compose
RUN pip3 install keepercommander
RUN npm install -g expo expo-cli

# Get Vim
RUN add-apt-repository ppa:jonathonf/vim -y && apt-get update && apt-get install vim-gtk3 -y

# Install ZSH
RUN sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd
ENV SHELL /bin/zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Add ZSH packages
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Add Ultimate vim RC
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
RUN sh ~/.vim_runtime/install_awesome_vimrc.sh

# Add  Vim Packages
RUN git clone https://github.com/mattn/emmet-vim.git ~/.vim_runtime/my_plugins/emmet-vim
RUN git clone https://github.com/othree/javascript-libraries-syntax.vim.git ~/.vim_runtime/my_plugins/javascript-libraries-syntax.vim
RUN git clone https://github.com/mhartington/oceanic-next.git ~/.vim_runtime/my_plugins/OceanicNext.vim
RUN git clone https://github.com/elzr/vim-json.git ~/.vim_runtime/my_plugins/vim-json
RUN git clone https://github.com/mxw/vim-jsx.git ~/.vim_runtime/my_plugins/vim-jsx
RUN git clone https://github.com/prettier/vim-prettier.git ~/.vim_runtime/my_plugins/vim-prettier
RUN git clone https://github.com/othree/yajs.vim.git ~/.vim_runtime/my_plugins/yajs.vim
RUN git clone https://github.com/ycm-core/YouCompleteMe.git ~/.vim_runtime/my_plugins/YouCompleteMe
RUN git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git ~/.vim_runtime/my_plugins/nerdtree-git-plugin 

# Install Prettier 
RUN npm install -g prettier
# Install YouCompleteMe
WORKDIR root/.vim_runtime/my_plugins/YouCompleteMe
RUN git submodule update --init --recursive
RUN python3 install.py --tern-completer
WORKDIR /

#=====================================================
#====================== Config =======================
#=====================================================

# SSH / MOSH
RUN mkdir /run/sshd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed 's/#Port 22/Port 3222/' -i /etc/ssh/sshd_config

RUN mkdir ~/.ssh && curl -fsL https://s3.amazonaws.com/gabeleibo-public-keys/ssh.keys > ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys

# Lang setup
ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
	locale-gen --purge $LANG && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=$LANG LC_ALL=$LC_ALL LANGUAGE=$LANGUAGE


# Correct colours is tmux
ENV TERM screen-256color

# Start
EXPOSE 3222 60000-60010/udp

WORKDIR /root

COPY pull-secrets.sh /bin/pull-secrets.sh 
RUN chmod +x /bin/pull-secrets.sh
	
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

CMD ["/bin/entrypoint.sh"]
