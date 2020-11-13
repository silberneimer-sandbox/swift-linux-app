FROM swift AS build

ENV HOME /home/gitpod
ENV WORKSPACE /workspace/workspace

USER gitpod
FROM gitpod/workspace-full
COPY --from=build /usr/bin/swiftc /usr/bin/

# Install Swift dependencies
RUN sudo apt-get update -q && \
    sudo apt-get install -yq libtinfo5 \
        libcurl4-openssl-dev \
        libncurses5 \
        libpython2.7 \
        libatomic1 \
        libcurl4 \
        libxml2 \
        libedit2 \
        libsqlite3-0 \
        libc6-dev \
        binutils \
        libpython2.7 \
        tzdata \
        git \
        pkg-config \
    && sudo rm -rf /var/lib/apt/lists/*

# swiftenv
ENV SWIFTENV_ROOT $HOME/.swiftenv
ENV PATH $SWIFTENV_ROOT/bin:$PATH
RUN eval "$(swiftenv init -)"

# Install Swift
# RUN mkdir -p /home/gitpod/.swift && \
#     cd /home/gitpod/.swift && \
#     curl -fsSL https://swift.org/builds/swift-5.3-release/ubuntu1804/swift-5.3-RELEASE/swift-5.3-RELEASE-ubuntu18.04.tar.gz | tar -xzv
# ENV PATH="$PATH:/home/gitpod/.swift/swift-5.3-RELEASE-ubuntu18.04/usr/bin"
