class Organization < ApplicationRecord
  has_many :members
  has_many :users, through: :members
  has_many :spaces
  has_many :pages, through: :spaces
end
