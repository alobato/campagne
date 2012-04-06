require 'resque/server'
Resque::Server.use(Rack::Auth::Basic) do |username, password|
  username == 'admin' && password == "secret"
end

Rails.application.class.configure do
  config.campagne_from_name = 'Foo'
  config.campagne_from_email = 'foo@bar.com'
  config.campagne_domain = 'foobar.com'
  config.campagne_base_url = 'http://www.foobar.com'
end
