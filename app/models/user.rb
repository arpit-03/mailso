require 'bcrypt'
class User < ApplicationRecord
	has_one_attached :avatar
	has_many :request 
	has_many :emailstatus
	 # has_secure_password
	 # attr_reader :password_hash 

	 
	#   attr_accessor :password
# 	include BCrypt
	
# def password
#     @password ||= Password.new(password_digest)
  
#   end

#   def password=(new_password)
#     @password = Password.create(new_password)
#     self.password_digest = @password
#   end
end
