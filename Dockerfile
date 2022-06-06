#####################x##################################################
# File: veracode-pipeline.df
# 
FROM curlimages/curl as retriever

ARG VERACODE_WRAPPER_VERSION="unknown"

ENV WORKDIR=/home/curl_user
WORKDIR ${WORKDIR}

# Retrive most recent veracode wrapper api jar file
RUN curl  https://downloads.veracode.com/securityscan/pipeline-scan-LATEST.zip --output pipeline.zip
RUN unzip pipeline.zip

RUN pwd
RUN ls -la .

#######################################################################
#FROM store/oracle/serverjre:8 as runtime
FROM alpine:latest as runtime

# Add Java Runtime Version 8
RUN apk add openjdk8-jre

#######################################################################
ARG VERSION="unknown"

ENV APPROOT="/app" \
	APP="pipeline-scan.jar" \
    VERACODE_ANALYSISCENTER_ID="" \
    VERACODE_ANALYSISCENTER_KEY="" 

# Create application directory
RUN mkdir ${APPROOT}

# Add AppRoot to the system search path
ENV PATH=$PATH:${APPROOT}
RUN echo $PATH

# Copy docker entrypoint script to container
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 555 /docker-entrypoint.sh

# Verify copying of docker-entrypoint.sh
RUN ls -la /

# Copy contents from retriever directory to application directory
COPY --from=retriever /home/curl_user ${APPROOT}

# Verify content has been moved to APPROOT
#RUN ls -la ${APPROOT}

# Update Labels
LABEL maintainer=jmok@veracode.com \
      base.name="Veracode Pipeline Scanner" \
      base.version="${VERSION}"

# change owner and permission on application wrapper
RUN chown root ${APPROOT}/${APP}
RUN chgrp root ${APPROOT}/${APP}
RUN chmod 555 ${APPROOT}/${APP}

# Verify configuration
RUN pwd
RUN ls -la .

# Verify Java and App Wrapper work
RUN java -version
RUN java -jar ${APPROOT}/${APP} -version

ENTRYPOINT ["/docker-entrypoint.sh"] 
CMD [""]
