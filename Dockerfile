FROM ros:melodic

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:timn/clips && \
    apt-get update && \
    apt-get install -y libmodbus-dev libclips-dev clips libclipsmm-dev \
        protobuf-compiler libprotobuf-dev libprotoc-dev \
        libboost1.65-dev libmodbus-dev \
        libglibmm-2.4-dev libgtkmm-3.0-dev libncurses5-dev \
        libncursesw5-dev libyaml-cpp-dev libavahi-client-dev git \
        libssl-dev libelf-dev mongodb-dev mongodb-clients \
        mongodb libzmq3-dev

# Add non-priviledged user
RUN groupadd -g 1000 ros && \
    useradd -r -u 1000 -g ros ros

ARG HOMEDIR="/home/ros"
ENV REFBOX_DIR=$HOMEDIR/refbox
RUN mkdir -p $REFBOX_DIR

# Copy referee box sources, in order to compile them
COPY --chown=ros:ros atwork_central_factory_hub $REFBOX_DIR
RUN chown -R ros:ros $HOMEDIR

USER ros

RUN cd $REFBOX_DIR && \
    make

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
