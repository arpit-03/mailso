class Email1Worker
	@queue= :email1
	
def self.perform (id,statid) 
	ActiveRecord::Base.clear_active_connections!

  	UserMailer.sendemail(id,statid).deliver_now
  	Emailstatus.find(statid).update(delivered: true , delivered_at: Time.now.strftime('%Y-%m-%d %H:%M:%S'))
  	end
end