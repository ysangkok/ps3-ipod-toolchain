FROM 9pkernel-done
RUN curl -L https://github.com/shuffle2/rockbox_psgroove/archive/psgroove-dev.tar.gz | gzip -cd | tar x
RUN curl http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz | gzip -cd | tar x
RUN (cd bzip2-1.0.6 && make bzip2 bzip2recover AR=/x86_64-linux-musl/bin/x86_64-linux-musl-ar CC=/x86_64-linux-musl/bin/x86_64-linux-musl-gcc && make install PREFIX=/usr)
COPY /usr/bin/bzip2 .
#RUN curl http://ftp.gnu.org/gnu/texinfo/texinfo-6.0.tar.gz | gzip -cd | tar x
#RUN (cd texinfo-6.0 && ./configure && make && make install)
RUN (cd rockbox_psgroove-psgroove-dev && sed -i -e 's/ makeinfo//' tools/rockboxdev.sh)
RUN (cd rockbox_psgroove-psgroove-dev && sed -i -e 's/tar xjf $dlwhere\/$file/\/usr\/bin\/bzip2 -cd < $dlwhere\/$file | tar x/' tools/rockboxdev.sh)
RUN (cd rockbox_psgroove-psgroove-dev && ln -fs /x86_64-linux-musl/bin/x86_64-linux-musl-gcc /usr/bin/gcc && echo "e" | tools/rockboxdev.sh)
