# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

Questions and Answers Thinknetica RoR advanced course application.

This app based on main idea of stackoverflow: people can ask questions and create answers for them, created for lerning how some gems and technologies works.

Features: Actions mostly works without reload. New records appears on page without reload for all users.

Ruby & Rails version

    ruby 2.7.6
    rails 6.1.4

Authentication:

    gem 'devise'
    gem 'omniauth'
    gem 'omniauth-github'
    gem 'omniauth-vkontakte'

Authorization

    gem cancancan

App has REST API

    gem 'active_model_serializers'
    gem 'doorkeeper'

Attach files to questions/answers with saving on cloud storage

    gem 'aws-sdk-s3'

Background jobs (like email)

    active job
    gem 'sidekiq'
    gem 'whenever'

Redis for sidekiq and caching

    Fragment caching (Russian doll caching)
    gem 'redis-rails'

Sphinx search (fulltext search)

    gem 'thinking-sphinx'

Test Driven Development

    gem 'rspec-rails'
    gem 'factory_bot_rails'
    gem 'shoulda-matchers'

Feature (acceptance) testing with JS

    gem 'capybara'

Views written on Slim & Bootstrap

    gem 'slim-rails'
    gem 'bootstrap'

Nested forms

    gem 'cocoon'

PostgreSQL as main db

    gem 'pg'

Ready to deploy

    gem 'capistrano'

Different production webserver

    gem 'unicorn'
    gem 'passenger'

Services (job queues, cache servers, search engines, etc.)

    Postgres
    Redis
    Sidekiq
    WebSockets
    Sphinx

Development instructions (how to run on local machine) System requirements

    Unix like OS
    Redis (http://redis.io)
    Sphinx (http://sphinxsearch.com)
    PostgreSQL (http://postgresql.org)
    MySQL (http://mysql.com)

Config files (copy and edit this files from .sample):

    config/database.yml
    congig/credentials.yml

Initial:

bundle
rails db:create
rails db:migrate
rake ts:index

Using App:

http://localhost:3000

Run tests:

rspec
