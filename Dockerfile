FROM ubuntu:16.04
MAINTAINER toolbox@cloudpassage.com

ARG task
ENV raketask $task

RUN \
  apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y build-essential && \
  apt-get install zlib1g-dev && \
  apt-get install -y ruby ruby-dev ruby-bundler && \
  apt-get install -y openssh-server && \
  rm -rf /var/lib/apt/lists/*

COPY ./ /source/

WORKDIR /source/

RUN mkdir /root/.aws
RUN gem install rake -v 10.5.0

RUN bundle install
RUN gem install winrm -v 2.1.2
RUN gem install winrm-fs
RUN gem install puppet
RUN gem install kitchen-puppet
RUN gem install kitchen-ec2

RUN puppet module install puppetlabs/apt
RUN puppet module install puppet/download_file
RUN puppet module install puppetlabs/powershell
RUN puppet module install puppetlabs/stdlib

CMD $raketask
