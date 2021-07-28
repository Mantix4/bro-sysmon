FROM debian:buster as builder


RUN apt-get update \
    && apt-get -y install libpcap0.8 libssl1.1 libmaxminddb0 python3 python3-dev gdb cmake build-essential libssl-dev\
    && apt-get clean && rm -rf /var/lib/apt/lists/*\
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 1 

COPY broker /app/broker
WORKDIR /app/broker
RUN ./configure && make && make install

COPY . /app
COPY SysmonAnalyzer/sysmon_analyzer /app
WORKDIR /app
ENTRYPOINT [ "python3", "-u", "/app/sysmon-Broker.py" ]
CMD ["-h"]
