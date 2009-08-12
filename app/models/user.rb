class User < ActiveRecord::Base
  validates_confirmation_of :email, :password
  validates_uniqueness_of :nickname, :email
  validates_presence_of :name, :nickname, :email, :password  
end
