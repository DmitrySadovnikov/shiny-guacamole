FROM ruby:2.6.3-alpine

COPY . /app
WORKDIR /app
RUN apk add --no-cache bash
RUN /bin/sh
RUN apk update && apk add --virtual build-dependencies build-base
RUN gem install bundler
RUN bundle install
ENTRYPOINT ["./entrypoint.sh"]
CMD ["robot"]
