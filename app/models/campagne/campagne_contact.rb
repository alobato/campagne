module Campagne
  class CampagneContact < ActiveRecord::Base
    has_and_belongs_to_many :campagne_lists

    attr_accessible :email, :name

    validates :email, :presence => true, :uniqueness => true
    validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  end
end
