FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

# https://software-dl.ti.com/processor-sdk-linux/esd/AM62AX/08_06_00_45/exports/docs/linux/Overview_Building_the_SDK.html

RUN apt-get update && \
    apt-get -f -y install \
        git \
        build-essential \
        diffstat \
        texinfo \
        gawk \
        chrpath \
        socat \
        doxygen \
        dos2unix \
        python3 \
        bison \
        flex \
        libssl-dev \
        u-boot-tools \
        mono-devel \
        mono-complete \
        curl \
        python3-distutils \
        repo \
        pseudo \
        python3-sphinx \
        g++-multilib \
        libc6-dev-i386 \
        jq \
        git-lfs \
        pigz \
        zstd \
        liblz4-tool \
        cpio \
        file \
        zstd \
        lz4 \
        wget

RUN dpkg-reconfigure dash

RUN \
    sh -c 'wget -q -O - https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz | tar Jxf - -C /opt' && \
    sh -c 'wget -q -O - https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz | tar Jxf - -C /opt'
ENV TOOLCHAIN_PATH_ARMV7 /opt/arm-gnu-toolchain-11.3.rel1-x86_64-arm-none-linux-gnueabihf
ENV TOOLCHAIN_PATH_ARMV8 /opt/arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu

# Create a non-root user that will perform the actual build
RUN id build 2>/dev/null || useradd --uid 1000 --create-home build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

# Fix error "Please use a locale setting which supports utf-8."
# See https://wiki.yoctoproject.org/wiki/TipsAndTricks/ResolvingLocaleIssues
RUN apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
        echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
        dpkg-reconfigure --frontend=noninteractive locales && \
        update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

USER build
WORKDIR /home/build
CMD "/bin/bash"
