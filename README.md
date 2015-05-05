## Rails Insights
This project is internal platform for [Slowpath](http://slowpath.com).


### Guidelines
Before you get involved in this project please get familiar with [Guide for programming style](http://github.com/thoughtbot/guides) documenting standard practices.

#### Setup development machine
For getting your development machine set up for Ruby on Rails development you can use [Laptop](http://github.com/thoughtbot/laptop). This shell script turns your Linux or Mac OS X laptop into an awesome development machine.

If you need to enhance your development machine you can use [Dotfiles](http://github.com/thoughtbot/dotfiles).
Dotfiles is a set of configuration files for zsh, vim, git, tmux, and ack.


### System dependencies
Make sure you have PostgreSQL 9.3+ installed in your system.


### Ruby & Rails version
Exact version of ruby is specified in `.ruby-version` file in root of project. Also specifiy ruby version in `Gemfile`.


### Configuration & Setup
Use bundler to install and maintaing gem dependencies. Use setup script to bootstrap your environment.

    bundle exec setup


### Database
Use PostgreSQL 9.3 or higher in all environments. For development environment it's recommended to use [Postgres.app](http://postgresapp.com/).

#### Database initialization & remigration
In development it's recommended to use following command which recreates & migrate database and seeds it with initial data.

    bundle exec rake db:remigrate

#### Database creation
    bundle exec rake db:create # create db

#### Database initialization & migration
    bundle exec rake db:migrate    # migrate db
    bundle exec rake devise:create # create user

    heroku run rake db:migrate # for staging server add option -a auditster-stage

#### Database backup & restore
    heroku pgbackups:capture
    curl -o ~/Downloads/latest.dump `heroku pgbackups:url`
    pg_restore --verbose -c -O -d rails_insights_development ~/Downloads/latest.dump

#### Transfering database from PRODUCTION to DEVELOPMENT via PUSH & PULL
pg-extras addon must be installed: `heroku plugins:install git://github.com/heroku/heroku-pg-extras.git`

    # pull from PRODUCTION to DEVELOPMENT
    dropdb rails_insights_development && heroku pg:pull DATABASE rails_insights_development

    # push from DEVELOPMENT to PRODUCTION
    heroku pgbackups:capture # OPTIONAL: backup database first
    heroku pg:reset DATABASE && heroku pg:push rails_insights_development DATABASE


### How to run the test suite
[Minitest](http://docs.seattlerb.org/minitest/) is used as a testing framework. For running whole test suite:

    bundle exec rake test

We're using standard Rails tests with Capybara and Poltergeist.

[Poltergiest](https://github.com/teampoltergeist/poltergeist)
Install phantomjs for poltergeist.

    brew install phantomjs


### Services (job queues, cache servers, search engines, etc.)
Currently we don't use any kind of these 3rd party services.


### Deployment instructions
Deployment is done with [Heroku's Git based deploy](https://devcenter.heroku.com/articles/git)
To deploy to production just run:

    git push heroku master

### How to contribute?
Get familiar with [Github Flow](https://guides.github.com/introduction/flow/index.html) and stick with it on this project.
We're using [Github Issues](https://github.com/slowpath/rails-insights/issues) as an issue tracker. All related tasks are there.
