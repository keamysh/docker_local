# Use official Tomcat 9 image
FROM tomcat:9.0

# Deploy your application WAR
# COPY target/*.war /usr/local/tomcat/webapps/web_artifact.war

# Restore manager and host-manager apps (required for Jenkins remote deployment)
RUN cp -r /usr/local/tomcat/webapps.dist/manager /usr/local/tomcat/webapps/manager && \
    cp -r /usr/local/tomcat/webapps.dist/host-manager /usr/local/tomcat/webapps/host-manager

# Remove default restrictive context.xml files
RUN rm -f /usr/local/tomcat/webapps/manager/META-INF/context.xml && \
    rm -f /usr/local/tomcat/webapps/host-manager/META-INF/context.xml

# Replace with permissive context.xml to allow remote Jenkins access
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
COPY context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml

# Add Tomcat user with manager roles (used by Jenkins deploy plugin)
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

# Expose the Tomcat HTTP port
EXPOSE 8080


