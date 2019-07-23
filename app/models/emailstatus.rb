class Emailstatus < ApplicationRecord
	has_one :request
	has_one :user
end

