Campagne
========

Campagne is a simple Rails 3 engine gem. It adds a admin painel (/campagne) to manage and send newsletters, email marketing campaigns, alerts, etc.

Campagne uses resque-scheduler to schedule deliveries.


1) Install redis and run redis-server
-------------------------------------

[http://redis.io](http://redis.io)

    $ redis-server


2) Rails 3 Gem
--------------

Include it in your Gemfile.

    gem 'campagne'


Next install it with Bundler.

    $ bundle


3) Generator
------------

Run campagne generator.

    $ rails g campagne

Change __config/initializers/campagne.rb__ configs.


4) Migration
------------

Run migration.

    $ rake db:migrate


5) Start
--------

Start Resque workers and resque-scheduler:

    $ rake resque:start_workers
    $ rake resque:start_scheduler

Now start your application:

    $ rails s
    
And open:

    http://localhost:3000/campagne
