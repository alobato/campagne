require 'rails/generators'
require 'rails/generators/migration'

class CampagneGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.new.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_migration_file
    migration_template 'migration.rb', 'db/migrate/create_campagne_tables.rb'
  end

  def copy_initializer_file
    copy_file 'initializer.rb', 'config/initializers/campagne.rb'
  end

  def copy_1_pixel_image
    copy_file "1x1.gif", "public/1x1.gif"
  end

end
