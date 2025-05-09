FROM tomcat:9.0
<<<<<<< HEAD
#COPY target/*.war /usr/local/tomcat/webapps_artifact/cohort7.war
=======
COPY target/*.war /usr/local/tomcat/webapps/web_artifact.war
>>>>>>> c51f952a5652eba433920a4ee769956e65087dc1
RUN cp -rf /usr/local/tomcat/webapps.dist/manager /usr/local/tomcat/webapps/manager && cp -rf /usr/local/tomcat/webapps.dist/host-manager /usr/local/tomcat/webapps/host-manager
RUN rm -rf /usr/local/tomcat/webapps/host-manager/META-INF/context.xml && rm -rf /usr/local/tomcat/webapps/manager/META-INF/context.xml
COPY context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
#
