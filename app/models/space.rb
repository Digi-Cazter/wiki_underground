class Space < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :pages
end
