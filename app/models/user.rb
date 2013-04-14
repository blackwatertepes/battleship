class User < ActiveRecord::Base
  attr_accessible :email, :name

  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /[\w\-\.]+@[\w\-\.]+\.[a-z]{2,5}/i

  has_many :games
end
