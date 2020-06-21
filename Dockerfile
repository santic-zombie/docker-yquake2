FROM debian:latest as builder
MAINTAINER Santic <admin@santic-zombie.ru>

RUN apt-get update && apt-get install -y git libcurl4-gnutls-dev \
    build-essential libsdl2-dev zlib1g-dev libgl1-mesa-dev \
    libopenal-dev
    
RUN git clone https://github.com/yquake2/yquake2 && \
    git clone https://github.com/yquake2/3zb2 && \
    git clone https://github.com/yquake2/ctf && \
    git clone https://github.com/yquake2/rogue && \
    git clone https://github.com/yquake2/xatrix && \
    git clone https://github.com/yquake2/zaero
    
WORKDIR /yquake2
RUN make

WORKDIR /3zb2
RUN make

WORKDIR /ctf
RUN make

WORKDIR /rogue
RUN make

WORKDIR /xatrix
RUN make

WORKDIR /zaero
RUN make


FROM debian:latest

RUN useradd -m -s /bin/bash quake2 && \
    mkdir -p /opt/yquake2/baseq2 && \
    mkdir -p /opt/yquake2/3zb2 && \
    mkdir -p /opt/yquake2/ctf && \
    mkdir -p opt/yquake2/rogue && \
    mkdir -p opt/yquake2/xatrix && \
    mkdir -p opt/yquake2/zaero
    
COPY --from=builder /yquake2/release/baseq2/game.so \
                    /opt/yquake2/baseq2/game.so
COPY --from=builder /3zb2/release/game.so \
                    /opt/yquake2/3zb2/game.so
COPY --from=builder /ctf/release/game.so \
                    /opt/yquake2/ctf/game.so
COPY --from=builder /rogue/release/game.so \
                    /opt/yquake2/rogue/game.so
COPY --from=builder /xatrix/release/game.so \
                    /opt/yquake2/xatrix/game.so
COPY --from=builder /zaero/release/game.so \
                    /opt/yquake2/zaero/game.so
COPY --from=builder /yquake2/release/q2ded /opt/yquake2/q2ded

EXPOSE 27910/udp

USER quake2

WORKDIR /opt/yquake2

ENTRYPOINT ["/opt/yquake2/q2ded"]


