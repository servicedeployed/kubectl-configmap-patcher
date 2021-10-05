FROM ubuntu

LABEL maintainer="innovoedge"

RUN apt-get update && apt-get install -yq curl && apt-get clean && rm -rf /var/lib/apt/lists

WORKDIR /app

COPY watcher.sh .
RUN chmod +x watcher.sh

ENV NAMESPACE=default
ENV CONFIG_MAP=config
ENV CONFIG_MAP_KEY=ip
ENV SERVICE=loadbalancer

CMD /app/watcher.sh
