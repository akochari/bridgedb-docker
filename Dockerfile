FROM openjdk:11-jdk

MAINTAINER BiGCaT

RUN apt-get update
RUN apt-get install jq -y

COPY setup.sh /
RUN chmod +x setup.sh
RUN /setup.sh

#The following 2 lines are normally commented out. For local, small scale testing, they can be used (see setup.sh for explanations). This would require the COPY of the .bridge file, and commenting out all lines related to the automated creation of gbd.config in the setup.sh script.
#COPY Hs_Derby_Ensembl_108.bridge /opt/bridgedb-databases/
#COPY gdb.config /opt/bridgedb/bridgedb/

COPY startup.sh /opt/bridgedb/bridgedb/
RUN chmod +x /opt/bridgedb/bridgedb/startup.sh

COPY start-script.sh ./start-script.sh
RUN chmod +x ./start-script.sh

ENV USER=username
ENV HOME=/home/$USER
RUN useradd -m -u 1000 $USER
RUN chown $USER /opt/bridgedb/bridgedb/
USER $USER

EXPOSE 8183 

ENTRYPOINT ["./start-script.sh"]
CMD ["-D", "FOREGROUND"]