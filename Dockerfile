FROM ruby:3.3

RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    sqlite3 \
    libsqlite3-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

