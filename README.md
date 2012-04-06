Campagne
========

A simple Rails 3 engine gem to manage and send newsletters.


    Use this on campaign body:
    
    ||WB|| - WebBeacon
    ||UNSUB|| - Unsubscribe
    ||LINK|| - Link

    # Add to Gemfile
    gem 'campagne'
    $ bundle
    
    $ bundle exec rails g campagne
    # Change config/initializers/campagne.rb
    
    $ bundle exec rake db:migrate
    http://localhost:3000/campagne
