FROM ruby:2.5.3

EXPOSE 8080
RUN useradd -m  -r appuser
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get install nmap -y
RUN mkdir /home/appuser/app
WORKDIR /home/appuser/app
ADD Gemfile /home/appuser/app/Gemfile
ADD Gemfile.lock /home/appuser/app/Gemfile.lock
RUN bundle install
ADD . /home/appuser/app/
CMD gem install mailcatcher
CMD mailcatcher
RUN rails db:migrate
RUN chown -R appuser:appuser /home/appuser/
USER appuser
CMD puma -p 8080
