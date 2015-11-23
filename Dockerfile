FROM psl1ght/psl1ght
COPY bigperl.bin /usr/bin/perl
RUN chmod +x /usr/bin/perl
#COPY curl-7.45.0.tar.bz2 .
#RUN (     tar xf curl-7.45.0.tar.bz2 \
#       && cd curl-7.45.0 \
#       && ./configure --prefix=/usr \
#       && make \
#       && make install \
#     ) \
#  && rm -rf curl-7.45.0
COPY texinfo-4.13a.tar.gz .
RUN cat texinfo-4.13a.tar.gz | gzip -cd | tar x
RUN (cd texinfo-4.13 && ./configure)
RUN (cd texinfo-4.13 && make || true)
RUN (cd texinfo-4.13 && make install)
RUN apt-get update && apt-get install -y curl
RUN git clone git://github.com/shuffle2/rockbox_psgroove.git
RUN cd rockbox_psgroove && git checkout psgroove-dev && git submodule init && git submodule update
RUN (cd rockbox_psgroove && sed -i -e 's/binopts=""/binopts="--disable-werror"/' tools/rockboxdev.sh)
RUN (cd rockbox_psgroove && echo "e" | sh -x tools/rockboxdev.sh)
#RUN curl -L https://github.com/kylon/ps3toolchain/archive/latest-and-greatest.tar.gz | gzip -cd | tar x
#RUN curl -L http://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz | gzip -cd | tar x && cd automake-1.15 && ./configure && make && make install
#RUN apt-get update && apt-get install -y bison
#RUN apt-get install -y libgmp-dev libgmp3-dev
#RUN apt-get install -y libelf-dev
#RUN apt-get install -y python-dev
#RUN apt-get install -y wget
#RUN cd ps3toolchain-latest-and-greatest && \
#    export PS3DEV=/usr/local/ps3dev && \
#    export PSL1GHT=$PS3DEV && \
#    export PATH=$PATH:$PS3DEV/bin && \
#    export PATH=$PATH:$PS3DEV/ppu/bin && \
#    export PATH=$PATH:$PS3DEV/spu/bin && \
#    echo $PATH && \
#    sh -x depends/check-automake.sh && \
#    sh -x ./toolchain.sh
#results in
#sysfs_wrapper.c
#In file included from /ps3toolchain-latest-and-greatest/build/psl1ght/ppu/sprx/libsysfs/./sysfs_wrapper.c:5:0:
#/ps3toolchain-latest-and-greatest/build/psl1ght/ppu/sprx/libsysfs/../../include/lv2/sysfs.h:42:14: error: 'MAXPATHLEN' undeclared here (not in a function)
#  char d_name[MAXPATHLEN + 1];
#              ^
#make[4]: *** [sysfs_wrapper.o] Error 1
#make[3]: *** [ppu] Error 2
#make[2]: *** [all] Error 2
#make[1]: *** [all] Error 2
#make: *** [all] Error 2
#+ echo ../scripts/008-psl1ght.sh: Failed.
#../scripts/008-psl1ght.sh: Failed.
#+ exit 1
#The command '/bin/sh -c cd ps3toolchain-latest-and-greatest &&     export PS3DEV=/usr/local/ps3dev &&     export PSL1GHT=$PS3DEV &&     export PATH=$PATH:$PS3DEV/bin &&     export PATH=$PATH:$PS3DEV/ppu/bin &&     export PATH=$PATH:$PS3DEV/spu/bin &&     echo $PATH &&     sh -x depends/check-automake.sh &&     sh -x ./toolchain.sh' returned a non-zero code: 1
