FROM quay.io/keycloak/keycloak:20.0.1 as builder

ENV KC_DB=postgres

COPY ./target/fairdata-keycloak-theme.jar /opt/keycloak/providers

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:20.0.1

COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://postgres:5432/keycloak
ENV KC_DB_USERNAME=postgres
ENV KC_DB_PASSWORD=postgres
ENV KC_HOSTNAME=localhost
ENV KC_HOSTNAME_STRICT_HTTPS=false
ENV KC_HOSTNAME_STRICT=false

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
