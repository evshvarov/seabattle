ARG IMAGE=intersystems/iris:2019.1.0S.111.0
ARG IMAGE=store/intersystems/iris-community:2019.3.0.309.0
ARG IMAGE=store/intersystems/iris-community:2019.4.0.379.0
FROM $IMAGE

USER root

WORKDIR /opt/seabattle
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/seabattle


USER irisowner

RUN mkdir -p /tmp/deps \

 && cd /tmp/deps \

 && wget -q https://pm.community.intersystems.com/packages/zpm/latest/installer -O zpm.xml


COPY  Installer.cls .
COPY  src src
COPY irissession.sh /

# running IRIS and open IRIS termninal in USER namespace
SHELL ["/irissession.sh"]
# below is objectscript executed in terminal
# each row is what you type in terminal and Enter
RUN \
  do $SYSTEM.OBJ.Load("Installer.cls", "ck") \
  set sc = ##class(App.Installer).setup() \
  Do $system.OBJ.Load("/tmp/deps/zpm.xml", "ck") \
  zn "IRISAPP" \
  zpm "install webterminal" 

# bringing the standard shell back
SHELL ["/bin/bash", "-c"]
CMD [ "-l", "/usr/irissys/mgr/messages.log" ]
