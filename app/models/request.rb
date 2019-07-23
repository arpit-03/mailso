class Request < ApplicationRecord
	has_one :user 
	has_many :emailstatus
	has_one_attached :cfile
end
