FROM node:slim
MAINTAINER Alex

# Install git, sudo
RUN apt-get -yq update && \
    apt-get -yq install git sudo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Add a user
RUN adduser --disabled-password --gecos '' user && \
	adduser user sudo && \
  	echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# Set HOME
ENV HOME /home/user

# Install lib dependencies
RUN apt-get -yq update && \
    apt-get -yq install xdg-utils bzip2 libfreetype6 libfontconfig && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install apps
RUN npm install -g yo gulp grunt-cli bower python phantomjs \
        jasmine-core karma-cli karma-phantomjs-launcher --save-dev \
        karma-jasmine --save-dev node-pre-gyp && \
    npm install karma --save-dev && \
    rm -rf ~/.npm && npm cache clear

# Install generators
RUN npm install -g generator-karma generator-ngbp generator-angular \
        generator-angular-fullstack generator-gulp-angular && \
    rm -rf ~/.npm && npm cache clear

#Install sass&compass
RUN apt-get update && \
    apt-get install -yq ruby2.1-dev && \
    apt-get install -yq ruby-ffi && \
    gem install sass && \
    gem install compass

#Stop infinite watch
#RUN echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# Set app dir
RUN mkdir /app && chown user:user /app
WORKDIR /app

# Run as user
USER user

# Expose the port
EXPOSE 9000 3000 3001

# Open bash by default
CMD /bin/bash
