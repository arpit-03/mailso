class UserMailer < ApplicationMailer
def sendemail(id,statid)
	

@id	=statid
@body = Request.find(id).body
headers "X-SMTPAPI" => {
  unique_args: {
   emailstatusid: @id
  }
}.to_json
	mail(
		to: Emailstatus.find(statid).to,
		from: Request.find(id).from,
		subject: 'MAIL'

		)


	end
	def checkemail(status,id)
	
	@status='Your Requst Has Been' + status.to_s

	mail(
		to: Request.find(id).from,
		from: 'mailjet@example.com',
		subject: "your request has been "+status


		)


	end
end
