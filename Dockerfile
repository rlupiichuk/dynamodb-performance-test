FROM ruby:2.3.1

ENV BUNDLE_PATH /app/.bundle

WORKDIR /app

CMD ["bundle", "exec", "ruby", "benchmark.rb"]
