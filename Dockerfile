FROM quay.io/quarkus/ubi-quarkus-native-image:22.3-java17 AS build
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN ./mvnw package -Dnative -Pnative

FROM registry.access.redhat.com/ubi8/ubi-minimal
COPY --from=build /usr/src/app/target/*-runner /application
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]
EXPOSE 8080
