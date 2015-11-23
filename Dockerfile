FROM gcc:4.9.2
COPY psgroove-dev.tar.gz .
RUN tar xf psgroove-dev.tar.gz
RUN apt-get install texinfo
RUN (cd rockbox_psgroove-psgroove-dev && echo "e" | tools/rockboxdev.sh)
