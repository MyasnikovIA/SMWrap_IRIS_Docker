ARG IMAGE=store/intersystems/irishealth:2019.3.0.308.0-community
ARG IMAGE=store/intersystems/iris-community:2019.3.0.309.0
ARG IMAGE=store/intersystems/iris-community:2019.4.0.379.0
ARG IMAGE=store/intersystems/iris-community:2020.1.0.199.0
ARG IMAGE=intersystemsdc/iris-community:2019.4.0.383.0-zpm
FROM $IMAGE

USER root

WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp

USER irisowner

COPY  Installer.cls .
COPY  src src
#COPY irissession.sh /
#SHELL ["/irissession.sh"]


#COPY fixoverlay.sh /
#CMD [ "-b", "/opt/irisapp/fixoverlay.sh" ]



RUN iris start $ISC_PACKAGE_INSTANCENAME quietly EmergencyId=sys,sys && \
    /bin/echo -e "sys\nsys\n" \
            " Do \$system.OBJ.Load(\"/opt/irisapp/Installer.cls\",\"ck\")\n" \
            " w \"Install ok\" \n" \
            " halt" \
    | iris session $ISC_PACKAGE_INSTANCENAME && \
    /bin/echo -e "sys\nsys\n" \
    | iris stop $ISC_PACKAGE_INSTANCENAME quietly
	

# 

# bringing the standard shell back
# SHELL ["/bin/bash", "-c"]
# Do $system.OBJ.Load("/opt/irisapp/src/Installer.cls","ck")