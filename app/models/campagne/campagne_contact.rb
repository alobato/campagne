module Campagne
  class CampagneContact < ActiveRecord::Base
    has_and_belongs_to_many :campagne_lists

    attr_accessible :email, :name

    validates :email, :presence => true, :uniqueness => true, :email => true, :incorrect_email => true, :denied_email => true

  end
end
