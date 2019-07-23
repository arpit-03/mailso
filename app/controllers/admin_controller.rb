
class AdminController < ApplicationController
  
  before_action :authorize_admin , except:[:index,:authorize]
 before_action :admin_start , except:[]
 before_action :adel , except:[:index,:authorize]
  @@a=1
  def index
 if(session[:a_login_id])
redirect_to home_path
 end
  end
def authorize
	@name= params[:username]
if(Admin.find_by(username: @name))
if(Admin.find_by(username: @name).password==params[:password])
  if(session[:a_in_pwrd]==true)
    session.delete(:a_in_pwrd)
  end
  if(session[:a_in_uname]==true)
    session.delete(:a_in_uname)
end
  session[:a_login_id]=Admin.find_by(username: @name).id
	redirect_to page_path
else
  session[:a_in_pwrd]=true
	redirect_to root2_path
end
else
  session[:a_in_uname]=true
	redirect_to root2_path
end

end
def error
end

def user
@user= User.new
end

def create
if(User.find_by(username: params[:user][:username]))
  session[:exist_user_a]=true
redirect_to user_path
else

  if(session[:exist_user_a])
    session.delete(:exist_user_a)
  end

	 @user = User.new(username: params[:user][:username])
  @user.password= params[:user][:password]
  @user.avatar.attach(params[:user][:avatar])
  @user.save
  redirect_to page_path

end
end

def page
 
  @sub =Sub.all
  end
  def pagecreate
    @sub= Sub.new
  end



  def pagecreate2
    if(params[:sub][:page_name]!="" && params[:sub][:title]!="" && params[:sub][:sh_desc]!="" && params[:sub][:lg_desc]!=""  && params[:sub][:meta_title]!="" && params[:sub][:meta_property]!="" && params[:sub][:meta_content]!="")
   if(Sub.find_by(page_name: params[:sub][:page_name]))
    session[:page_exist]=true
    redirect_to pg_create_path

  else

   if( session[:page_exist])
    session.delete(:page_exist)
  end

    status=params[:sub][:status]
    i=0

    if(status=='active')
      i=1
    end

    @sub= Sub.create(page_name: params[:sub][:page_name], title: params[:sub][:title], sh_desc: params[:sub][:sh_desc],
    lg_desc: params[:sub][:lg_desc], status: i, meta_title: params[:sub][:meta_title], meta_property: params[:sub][:meta_property] ,
    meta_content: params[:sub][:meta_content] )
  redirect_to page_path
end
else
  redirect_to page_path 

end
end
def edit
@sub=Sub.find(params[:id])
end
def update
  if(params[:sub][:page_name]!="" && params[:sub][:title]!="" && params[:sub][:sh_desc]!="" && params[:sub][:lg_desc]!=""  && params[:sub][:meta_title]!="" && params[:sub][:meta_property]!="" && params[:sub][:meta_content]!="")
a= Sub.find(params[:id])
status=params[:sub][:status]
i=0
    if(status=='active')
      i=1
    end
a.update(page_name: params[:sub][:page_name], title: params[:sub][:title], sh_desc: params[:sub][:sh_desc],
    lg_desc: params[:sub][:lg_desc], status: i, meta_title: params[:sub][:meta_title], meta_property: params[:sub][:meta_property] ,
    meta_content: params[:sub][:meta_content])
# a.image.attach(params[:images])
redirect_to page_path
else
  redirect_to sub_edit_path(params[:id])
end
  end
  def delete
    @tid=params[:id]
    
    @tid.each do |s|
    s.slice! 't'
  end
    @tid.each do |s|
    if(Sub.all.size >1)
     
Sub.find(s).destroy
end

end
  

  end
  def active
    @tid=params[:id]
@tid.each do |t|
  t.slice! 't'
  end
  
  @tid.each do |t|
    a=Sub.find(t)
if(a.status==0)

  a.update(status: 1)

end

  end 
  end
  def inactive
    @tid=params[:id]
    if @tid.length== Sub.all.where(status: 1).size
 return render json: {
  id: 1,
 }
    else
 
    
@tid.each do |t|
  t.slice! 't'
  end
  @sub=nil
    @tid.each do |t|
    a=Sub.find(t)

if(a.status==1)
if(a.sequence==1)
  a.update(status: 0)
 @sub=a
else
  a.update(status: 0)
end
end
end
if(@sub)
 @sub.update(sequence: nil)
  Sub.where(status: 1).first.update(sequence: 1)
end
 return render json: {
  id: 0,
 }
  end 
  end
  def toggle
# @tid=params[:id]
# @tid.each do |t|
#   t.slice! 't'
#   end
#   @sub=null
#   @tid.each do |t|
#     a=Sub.find(t)
# if(a.status==0)

#   a.status==1

# end

#   end 

#   @si=true
#   @c= 'close'
#     @id= params[:id]
# @a= Sub.find(params[:id])
# @status= @a.status
# if(Sub.where(status:1).size > 1)
# if(@a.status==1)
#   if(@a.sequence==1)
# @a.update(status: 0)
# @a.update(sequence: nil)
# @b=Sub.where(status: 1).first
# @b.update(sequence: 1)

# @c= 'open'
# else

#   @a.update(status: 0)
# end

# else
  
# @a.update(status: 1)
# end
# else 
#   @si =false 
#   if(@a.status==0)
#     @a.update(status: 1)
#   end


  end
  def changeindex
  
  
  end
  def changeindex2
@sub=Sub.find_by(page_name: params[:page_name])

s= Sub.find_by(sequence: 1)
s.update(sequence: nil)
s= Sub.find(@sub.id)
s.update(sequence: 1)
redirect_to page_path
  end

  def authorize_admin
if !session[:a_login_id]
redirect_to root2_path
end
  end
  def logout
session.delete(:a_login_id)
redirect_to root2_path
  end

  def admin_start
@admin=true
  end
def adel
  if(session[:exist_user_a])
    session.delete(:exist_user_a)
  end
   if( session[:page_exist])
    session.delete(:page_exist)
  end
end
def useredit
  end

  def requests
  end

  def body
@id=params[:id]
@body=Request.find(@id).body
  end


def msend
  require 'csv'
que=Resque.queues
  que.each do |q|
if(q.include?("email") )
  if(Resque.size(q)==0)
Resque.remove_queue(q)
end
end
  end

@id=params[:id]
@id.each do |t|
  t.slice! 'r'
  end
  
@id.each do |id|

  if(Request.find(id).status!='denied')
  
@csv=CSV.parse(Request.find(id).cfile.download,headers: true)

@csv.by_col[0].each do |row|

  @emailstat=Emailstatus.create(request_id: id,to:row,sent: false ,delivered: false,bounced: false, opened: false, clicked:false)
i=find_minimum_queue2

Resque.enqueue_to('email'+i.to_s,Email1Worker,id,@emailstat.id)
@emailstat.update(sent: true)

@emailstat.update(sent_at: Time.now.strftime('%Y-%m-%d %H:%M:%S'))


end
Request.find(id).update(status: 'approved')
Resque.enqueue(CheckWorker, 'approved',id)
  end

end
end

def find_minimum_queue2
i=1
r=0
limit= 2
j=find_minimum_queue
if(Resque.size('email'+j.to_s)>=limit)
@@a=@@a+1
return @@a
end
return j;
end

def find_minimum_queue
    i=1
    r=1
    size=Resque.size("email"+i.to_s)
    while i<@@a
    i=i+1
    if size>Resque.size("email"+i.to_s)
      size=Resque.size("email"+i.to_s)
      r=i
    end

    end
    return r
  end
def mcancel
@id=params[:id]
@id.each do |t|
  t.slice! 'r'
  end
  @id.each do |id|
if(Request.find(id).status=='processing')
  Request.find(id).update(status: 'denied')
  Resque.enqueue(CheckWorker, 'denied',id)
  end
end
end
def mdel
@id=params[:id]
@id.each do |t|
  t.slice! 'r'
  end
  @id.each do |id|
Request.find(id).destroy
end
end

def userdel
@id=params[:id]
@id.each do |t|
  t.slice! 'r'
  
  end


  @id.each do |u|

    @rid=Request.where(userid: u)
    @rid.each do |r|
Request.find(r.id).destroy
    end
User.find(u).destroy

  end
  end
 

  
def home
end
def adminreqdetails
  @id = params[:id]
  @s=Emailstatus.where(request_id: @id,sent: true).size
@d=Emailstatus.where(request_id: @id,delivered: true).size
@b=Emailstatus.where(request_id: @id,bounced: true).size
@o=Emailstatus.where(request_id: @id,opened: true).size
@c=Emailstatus.where(request_id: @id,clicked: true).size
  end
end
