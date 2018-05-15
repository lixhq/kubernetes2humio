FROM fluent/fluentd-kubernetes-daemonset:v1.1-debian-elasticsearch

RUN export BUILD_DEPS="sudo make gcc g++ libc-dev libffi-dev ruby2.3-dev" && \
    apt-get update && \
    apt-get install -y $BUILD_DEPS && \
    fluent-gem install fluent-plugin-record-modifier && \
    fluent-gem install fluent-plugin-rewrite-tag-filter && \
    fluent-gem install fluent-plugin-concat -v 2.2.2 && \
    fluent-gem install fluent-plugin-systemd -v 1.0.0 && \
    SUDO_FORCE_REMOVE=yes apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $BUILD_DEPS && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem && \
    gem sources --clear-all

# setup forwarding settings for humio
COPY kubernetes.conf /fluentd/etc/kubernetes.conf
COPY fluent.conf /fluentd/etc/fluent.conf
#COPY testmultiline.conf /fluentd/etc/fluent.conf

# requires envvars specifying: FLUENT_HUMIO_HOST, FLUENT_HUMIO_DATA_SPACE, FLUENT_HUMIO_INGEST_TOKEN
