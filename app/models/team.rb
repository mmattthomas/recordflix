class Team < ApplicationRecord
    has_many :users
    has_many :movies

    attr_accessor :invite_email_addresses
end
