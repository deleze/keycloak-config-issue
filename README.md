# Issue with the env variables

The configuration via environment variable doesn't work anymore as describe in the documentation: https://www.keycloak.org/server/configuration#_using_environment_variables_for_configuration_values

In the version 21.1.1 the variable substitution in `keycloak.conf` doesn't work anymore. The same configuration was working with 20.0.3.

- `${KEYCLOAK_LOGLEVEL:INFO}` result as `INFO}` with a `}` at the end
- `${KEYCLOAK_LOGLEVEL}` result as `${KEYCLOAK_LOGLEVEL}`

Content of `conf/keycloak.conf` with an environment variable substitution

```
log-console-color=true

log-level=${KEYCLOAK_LOGLEVEL:INFO}
```

## 20.0.3 -> OK

```shell
docker build -t deleze/keycloak:20.0.3 -f ./Dockerfile_20.0.3 .
docker run --rm --name k20 -p 8080:8080 deleze/keycloak:20.0.3
```
Open http://localhost:8080/auth/admin

## 21.1.1 -> NOT OK

```shell
docker build -t deleze/keycloak:21.1.1  .
docker run --rm --name k21 -p 8080:8080 deleze/keycloak:21.1.1
```

The server didn't start because the substitutions result of `${KEYCLOAK_LOGLEVEL:INFO}` result as `INFO}` with a `}` at the end.  


```shell
docker build -t deleze/keycloak:21.1.1  .
docker run --rm --name k21 -p 8080:8080 -e "KEYCLOAK_LOGLEVEL=DEBUG" deleze/keycloak:21.1.1
```
