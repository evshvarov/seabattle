ARG IMAGE=intersystemsdc/irishealth-community
ARG IMAGE=intersystemsdc/iris-community
ARG IMAGE=intersystemsdc/iris-community:preview
FROM $IMAGE

WORKDIR /home/irisowner/irisbuild

ARG TESTS=0
ARG MODULE="eshvarov-sample-seabattle"
ARG NAMESPACE="USER"

RUN --mount=type=bind,src=.,dst=. \
    iris start IRIS && \
	iris session IRIS < iris.script && \
    ([ $TESTS -eq 0 ] || iris session iris -U $NAMESPACE "##class(%ZPM.PackageManager).Shell(\"test $MODULE -v -only\",1,1)") && \
    iris stop IRIS quietly