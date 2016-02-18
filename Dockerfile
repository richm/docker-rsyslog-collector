FROM centos:centos7
MAINTAINER The ViaQ Community <community@TBA>

EXPOSE 5141

ENV HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:$PATH \
    SYSLOG_LISTEN_PORT=5141 \
    AMQP_HOST=viaq-qpid-router \
    AMQP_PORT=5672

#RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \

RUN curl https://copr.fedorainfracloud.org/coprs/rmeggins/rsyslogv8-omamqp1/repo/epel-7/rmeggins-rsyslogv8-omamqp1-epel-7.repo > /etc/yum.repos.d/rmeggins-rsyslogv8-omamqp1-epel-7.repo && \
    curl https://copr.fedorainfracloud.org/coprs/portante/rsyslog-v8.15/repo/epel-7/portante-rsyslog-v8.15-epel-7.repo > /etc/yum.repos.d/portante-rsyslog-v8.15-epel-7.repo && \
    yum install -y rsyslog rsyslog-gssapi \
    rsyslog-mmjsonparse rsyslog-mmsnmptrapd rsyslog-omamqp1 && \
    yum clean all && \
    rm /etc/rsyslog.d/listen.conf

ADD rsyslog.conf /etc/rsyslog.conf
ADD rsyslog.d/* /etc/rsyslog.d/
ADD run.sh /usr/sbin/
WORKDIR /var/lib/rsyslog

CMD /usr/sbin/run.sh
