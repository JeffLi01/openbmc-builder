FROM ubuntu:20.04

ENV LANG="en_US.UTF-8"

ARG UBUNTU_MIRROR=http://mirrors.tuna.tsinghua.edu.cn/ubuntu/

RUN { [ ! "$UBUNTU_MIRROR" ] || sed -i "s|http://\(\w*\.\)*archive\.ubuntu\.com/ubuntu/\? |$UBUNTU_MIRROR |" /etc/apt/sources.list; } && \
    apt-get -q update && \
    apt-get -q dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive \
        apt-get -q install --no-install-recommends -y \
            bzip2 ca-certificates chrpath cpio diffstat file g++ gawk gcc git \
            language-pack-en locales lsb-release lz4 make \
            openssh-client patch python3 python3-distutils tzdata \
            wget zstd

RUN useradd builder
RUN mkdir -p /home/builder && chown builder:builder /home/builder
USER builder
