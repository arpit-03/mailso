class CheckWorker
@queue= :check
def self.perform(status,id)
ActiveRecord::Base.clear_active_connections!
	UserMailer.checkemail(status,id).deliver_now
	end
end