FROM registry.cn-shenzhen.aliyuncs.com/philiphuang/webspoon-docker:tomcat-9-jre8 

LABEL maintainer="dzd624175217@gmail.com"

ENV MYSQL_CONNECTOR_VERSION=5.1.49 \
    KETTLE_HOME="/home/tomcat/.pentaho"

ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get clean && apt-get update \
        && apt-get install --assume-yes apt-utils \
        && apt-get install -y vim locales ttf-wqy-zenhei ibus ibus-gtk ibus-pinyin

RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 \
 && echo "Asia/Shanghai" > /etc/timezone

USER tomcat

# 添加mysql驱动
ADD --chown=tomcat:tomcat https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar ${CATALINA_HOME}/webapps/spoon/WEB-INF/lib/

# 中文
ENV LANG=zh_CN.utf8
ENV LC_ALL=zh_CN.utf8
