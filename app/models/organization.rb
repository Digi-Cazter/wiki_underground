class Organization < ApplicationRecord
  has_many :members
  has_many :users, through: :members
  has_many :spaces, as: :owner
  has_many :pages, through: :spaces
end
