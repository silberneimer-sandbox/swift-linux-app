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
RUN git clone https://github.com/kylef/swiftenv.git ~/.swiftenv
RUN { echo; \
      echo 'export SWIFTENV_ROOT="$HOME/.swiftenv"'; \
      echo 'export PATH="$SWIFTENV_ROOT/bin:$PATH"'; \
      echo 'eval "$(swiftenv init -)"'; } >> ~/.bashrc
