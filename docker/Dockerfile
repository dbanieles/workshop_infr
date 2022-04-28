FROM nginx:latest

RUN apt-get -qq update; apt-get -qq -y install curl

EXPOSE 8080

#CMD [ "for i in `seq 1 10`; do curl -s http://localhost:8080/api/v1/notifications; done"]
#ENTRYPOINT ["/bin/sh", "-c", "for i in `seq 1 10000`; do curl -s http://svc-restapi:8080/health; done"] 