FROM ubuntu:16.04
MAINTAINER Lin Lan

RUN apt-get update && apt-get upgrade && apt-get -y install --no-install-recommends git && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR ~/

RUN wget -O ~/Anaconda2-5.0.1-Linux-x86_64.sh https://repo.continuum.io/archive/Anaconda2-5.0.1-Linux-x86_64.sh && bash ~/Anaconda2-5.0.1-Linux-x86_64.sh && pip install tensorflow

RUN git clone --depth 1 https://github.com/DamnWidget/anaconda.git ~/Anaconda

EXPOSE 2222

ENTRYPOINT ["python ~/Anaconda/anaconda_server/minserver.py 2222"]