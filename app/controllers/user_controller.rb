class UserController < ApplicationController
	before_action :authorize_user , only: [:emailcenter,:createrequest] 
  before_action :authorize_user1 , only: [:login] 
	before_action :user_start , except: []
  def index
    
     if(session[:incorrect_password])
      session.delete(:incorrect_password)
    end
    if(session[:incorrect_username])
      session.delete(:incorrect_username)
      
    end
  	if(session[:login_id])
  	@current_user_id= session[:login_id]
  end
  	@s=Sub.all
  	if(session[:page_id])
  	@sub=Sub.find(session[:page_id])
  	session.delete(:page_id)
  	else
  	@sub=Sub.find_by(sequence: 1)
  end
  	@length= @s.size
  	@id=@sub.id
  	@page_name=@sub.page_name
  	@title=@sub.title
  	@lg_desc=@sub.lg_desc.html_safe
  	@meta_title=@sub.meta_title
  	@meta_property=@sub.meta_property
  	@meta_content=@sub.meta_content

  end
 def login
 
   
 end
def check
  @ck=false
	a=User.find_by(username: params[:username])
if(a)
	if(a.password==params[:password])
		session[:login_id]=a.id
    if(session[:incorrect_password])
      session.delete(:incorrect_password)
    end
    if(session[:incorrect_username])
      session.delete(:incorrect_username)
      
    end
redirect_to root_path
else
  session[:incorrect_password]=true
	redirect_to login_path
	end
else
  session[:incorrect_username]=true
	redirect_to login_path
end
end
def change_index
@id=params[:id]
@sub=Sub.find(@id)
end
def logout

session.delete(:login_id)
redirect_to root_path
	end

	def authorize_user
if(!session[:login_id])
	redirect_to root_path

end
end
  def authorize_user1 
if(session[:login_id])
  redirect_to root_path

end
	end
	def redirect_to_index
@id=params[:id]
session[:page_id]= @id
redirect_to root_path
	end
	def user_start
@user=true
	end
  def excel
  end
  def emailcenter
    @request=Request.new
@current_user_id= session[:login_id]
  end
  def createrequest
    d=Time.now.strftime('%Y-%m-%d %H:%M:%S')
# d.strftime("%d/%m/%Y %H:%M:%S")
@request= Request.create(userid: session[:login_id],from: params[:request][:from],body: params[:request][:body],uploaded_at: d,status: 'processing')
Rails.logger.info(@request.errors.inspect) 
@request.cfile.attach(params[:request][:cfile])

redirect_to root_path

  end
  def mainemail
@current_user_id= session[:login_id]
  end
  require 'csv'
  def reqdetails
@id= params[:id]
@current_user_id= session[:login_id]
@csv=CSV.parse(Request.find(@id).cfile.download,headers: true)
@s=Emailstatus.where(request_id: @id,sent: true).size
@d=Emailstatus.where(request_id: @id,delivered: true).size
@b=Emailstatus.where(request_id: @id,bounced: true).size
@o=Emailstatus.where(request_id: @id,opened: true).size
@c=Emailstatus.where(request_id: @id,clicked: true).size
  end
end
