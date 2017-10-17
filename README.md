# Accounts Receivable

Welcome to the Accounts Receivable system! This system is responsible for
creating, sending, and tracking invoices sent to clients so we can be paid for
our products and services.

## Getting started

### Prerequisites

Before you get started, be sure to:

* Be running a supported version of Ruby (we'd recommend MRI version 2.3 or
  higher)
* That your system is ready to compile gems with native extensions (on a Mac
  with homebrew, it may be worth running `brew doctor` to verify everything is
  ready)
* That you have a recent version of Bundler installed (e.g. `gem install
  bundler`)
* That you have a recent version of git installed (e.g. `brew install git` on a
  Mac)

### Initial setup

This is a conventional Ruby on Rails app, so you should be able to get up and
running with the following commands:

```
$ bundle install
$ bundle exec rake db:create db:migrate db:fixtures:load
```

(Note that in addition to running migrations, we're also loading the app's
fixtures into the development database to help move things along.)

If nothing blew up, you should be able to start the Rails server:

```
$ bundle exec rails server
```

And then you should be able to see pre-generated invoices in a browser:
[http://localhost:3000/invoices](http://localhost:3000/invoices)



