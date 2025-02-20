FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN apt-get -qq update
RUN apt-get -qq install -y git python3 python3-pip \
    locales python3-lxml aria2 \
    curl pv jq nginx npm
	
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt && \
    apt-get -qq purge git
	
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY . .

RUN chmod +x start.sh
RUN chmod +x gclone

CMD ["bash","start.sh"]
