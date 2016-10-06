FROM phusion/baseimage
MAINTAINER schuyler@jewlr.com

# Install monitoring scripts

RUN apt-get update && \
  apt-get install -y unzip wget libwww-perl libdatetime-perl && \
  rm -rf /tmp/* /var/tmp/*

RUN wget http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip && \
  unzip CloudWatchMonitoringScripts-1.2.1.zip && \
  rm CloudWatchMonitoringScripts-1.2.1.zip

WORKDIR aws-scripts-mon

# We are making this on the fly
# COPY awscreds.template awscreds.template

# Setup cron

ADD crontab /etc/crontab

# Log file for debugging

RUN touch /var/log/cron.log && touch /var/log/cloudwatch.log
RUN chmod 0644 /var/log/cron.log

CMD touch /etc/crontab && /sbin/my_init
