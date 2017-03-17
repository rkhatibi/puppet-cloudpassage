FROM ubuntu:16.04
MAINTAINER toolbox@cloudpassage.com

ARG task

RUN echo ${task}
CMD ${task}
