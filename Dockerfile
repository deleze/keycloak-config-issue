FROM quay.io/keycloak/keycloak:21.1.1 as builder

ENV KC_DB="dev-mem" \
    KC_HTTP_RELATIVE_PATH="/auth"

COPY conf/keycloak.conf /opt/keycloak/conf/

RUN /opt/keycloak/bin/kc.sh build

###############################################################
FROM quay.io/keycloak/keycloak:21.1.1
COPY --from=builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak

ENV KC_DB="dev-mem" \
    KC_HOSTNAME_STRICT="false" \
    KC_PROXY="edge" \
    KC_START_CMD="start --optimized"

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "$KC_START_CMD"]
