FROM phusion/baseimage:0.9.16

MAINTAINER Michael Keirnan <michael@keirnan.com>

ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get clean
RUN apt-get install -y python-pip
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install rq-dashboard Flask-BasicAuth

COPY etc/ /etc/
COPY dash.py /

EXPOSE 9181
