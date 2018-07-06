FROM ruby:alpine as build
RUN apk add --update build-base cmake git && rm -rf /var/cache/apk/*

# Define where the working directory for pronto. This is where the source codes will be mapped
ENV PRONTO_ROOT /data
WORKDIR $PRONTO_ROOT

RUN gem install pronto pronto-rubocop pronto-flay rubocop flay

FROM ruby:alpine as runner
COPY --from=build /usr/local/bundle /usr/local/bundle

CMD [ "pronto", "run" ]
