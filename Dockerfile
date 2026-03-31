FROM ruby:3 AS build

WORKDIR /src
COPY . .
RUN gem install jekyll && \
    gem install pygments.rb && \
    gem install jekyll-timeago -v 0.14 && \
    gem install bundler -v 4.0.1
RUN bundle install
RUN jekyll build -d public

FROM caddy:2-alpine AS production
COPY --from=build /src/public /html
COPY Caddyfile /etc/caddy/Caddyfile
EXPOSE 4000
