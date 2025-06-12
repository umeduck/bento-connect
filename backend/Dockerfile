FROM ruby:3.3
WORKDIR /app
COPY ./Gemfile* ./
RUN bundle install
COPY . .
CMD ["bin/rails", "s", "-b", "0.0.0.0"]