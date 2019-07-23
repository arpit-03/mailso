module Api 
	module V1 
		class SubController< ApplicationController 
			def shomemini
@id= params[:id]
				
draw= params[:draw] 
start= params[:start] 
length= params[:length]
search=params[:search]
order1= params[:order] 
 column=order1['0']['column'] 
 direction=order1['0']['dir']  
 arr=["","emailstatuses.to","sent","delivered","bounced","opened","clicked"]
 # if(column["value"]=="")
 	
 # else
 # end
 

 if(arr[column.to_i]=="")
 if(search["value"]=="")

@mini1= Emailstatus.where(request_id: @id)
@mini=@mini1.offset(start).limit(length)

 else

@mini1= Emailstatus.where(request_id: @id).where('emailstatuses.to like ?' ,"%"+search['value']+"%")
@mini=@mini1.offset(start).limit(length)
end
else
 if(search["value"]=="")

@mini1= Emailstatus.where(request_id: @id).order(arr[column.to_i]+" "+direction)
@mini=@mini1.offset(start).limit(length)
 else
@mini1= Emailstatus.where(request_id: @id).where('emailstatuses.to like ?' ,"%"+search['value']+"%").order(arr[column.to_i]+" "+direction)
@mini=@mini1.offset(start).limit(length)
end
end
 size= @mini1.size
shomemini=[]
@mini.each do |m|
rowid='m'+m.id.to_s
k=Minisub.new(rowid,m.to,m.sent,m.delivered,m.bounced,m.opened,m.clicked)
shomemini.push(k)
end
 	  return render json:{ draw: draw, 
 	  	recordsTotal: size,
 	  	 recordsFiltered: size,
 	  	  data: shomemini } 
end 

			
			def shome
start= params[:start] 
length= params[:length] 
draw= params[:draw] 
search=params[:search]
 order1= params[:order] 
 column=order1['0']['column'] 
 direction=order1['0']['dir'] 
 arr=["","userid","username","id","requests.from","sent","delivered","bounced","opened","clicked"]

if (column["value"]=="")
if(search["value"]=="")

@stat1= Request.joins('LEFT JOIN users ON users.id=requests.userid').select('requests.id','requests.from','requests.userid','users.username')
@stat=@stat1.offset(start).limit(length)
else
	@stat1= Request.joins('LEFT JOIN users ON users.id=requests.userid').select('requests.id','requests.from','requests.userid','users.username').where('username like ?' ,"%"+search['value']+"%")
@stat=@stat1.offset(start).limit(length)
end
else
	if(search["value"]=="")
@stat1= Request.joins('LEFT JOIN users ON users.id=requests.userid').select('requests.id','requests.from','requests.userid','users.username').order(arr[column.to_i]+" "+direction)
@stat= @stat1.offset(start).limit(length)
else
	@stat1= Request.joins('LEFT JOIN users ON users.id=requests.userid').select('requests.id','requests.from','requests.userid','users.username').where('username like ?' ,"%"+search['value']+"%").order(arr[column.to_i]+" "+direction)
@stat=@stat1.offset(start).limit(length)
end
	end
	size= @stat1.size
shome=[]
 @stat.each do |u| 
 	rowid='rh'+u.id.to_s 
 	details="<a href='/admin/req/details/"+u.id.to_s+"'><i class='fas fa-search-plus'></i></a>"
 	k=Homesub.new(rowid,u.userid,u.username,u.id,u.from,Emailstatus.where(request_id:u.id).where(sent: true).size,Emailstatus.where(request_id: u.id).where(delivered: true).size,Emailstatus.where(request_id: u.id).where(bounced: true).size, Emailstatus.where(request_id: u.id).where(opened: true).size ,Emailstatus.where(request_id: u.id).where(clicked: true).size,details) 
 	shome.push(k)
 	 end
 	  return render json:{ draw: draw, 
 	  	recordsTotal: size,
 	  	 recordsFiltered: size,
 	  	  data: shome } 
 	  	end 
 	  	def susr
start= params[:start] 
length= params[:length]
 draw= params[:draw]
size=User.all.size 
search=params[:search]
 order1= params[:order] 
 column=order1['0']['column'] 
 direction=order1['0']['dir'] 
 arr=["","id","username",""]
if(search['value']!="")
 @user= User.where('username like ?' ,"%"+search['value']+"%").order(arr[column.to_i]+" "+direction).offset(start).limit(length) 
else
 @user=User.order(arr[column.to_i]+" "+direction).offset(start).limit(length)
  end
susr=[]
 @user.each do |u| 
 	rowid= "r"+u.id.to_s 
 	if(u.avatar.attached?) 
 		k=Usrsub.new(rowid,u.id,u.username,'<img src="'+url_for(u.avatar)+'"class="picsub">')

else
k= Usrsub.new(rowid,u.id,u.username,'<img src="/assets/u.jpg" class="picsub">')
	end
susr.push(k)
end
return render json: {
	draw: draw,
	recordsTotal: size,
	recordsFiltered: size,
	data: susr
}
		end
	def sreq
start= params[:start]
length= params[:length]
draw= params[:draw]
search=params[:search]

order1= params[:order]
column= order1['0']['column']
direction=order1['0']['dir']
cols= params[:columns]
status=cols["8"]["search"]['value']
date=cols['7']['search']['value']

@f="0000-00-00"
@t="9999-99-99"
if(date.length!=0)
if(date[1]=="T")
@t=date[2,date.length-1]
@t[@t.length-1]= (@t[@t.length-1].to_i+1).to_s
elsif (date[date.length-1]=="T")
	@f=date[1,date.length-2]

else

@f=date[1,10]
@t=date[12,date.length]
	@t[@t.length-1]= (@t[@t.length-1].to_i+1).to_s
	end
end
arr=['','requests.id','requests.userid','users.username','requests.from','','','requests.uploaded_at','requests.status']

if(cols["8"]["search"]['value']=="")
if(search['value']!="")
	# @r=Request.joins('LEFT INNER JOIN "users" ON "users"."id"= "requests"."userid"')
	
@req1=Request.joins('LEFT JOIN users ON users.id= requests.userid').select('requests.*,users.username').where("uploaded_at >= :start_date AND uploaded_at < :end_date",
  {start_date: @f, end_date: @t}).where("users.username like ?", '%'+search['value']+'%').order(arr[column.to_i]+' '+ direction);
@req=@req1.offset(start).limit(length)
else
@req1=Request.joins('LEFT JOIN users ON users.id= requests.userid').select('requests.*,users.username').where("uploaded_at >= :start_date AND uploaded_at <= :end_date",
  {start_date: @f, end_date: @t}).order(arr[column.to_i]+' '+ direction);
	@req=@req1.offset(start).limit(length)
	end
else
		if(search['value']!="")
	# @r=Request.joins('LEFT INNER JOIN "users" ON "users"."id"= "requests"."userid"')
	
@req1=Request.joins('LEFT JOIN users ON users.id= requests.userid').select('requests.*,users.username').where("uploaded_at >= :start_date AND uploaded_at <= :end_date",
  {start_date: @f, end_date: @t}).where(status: status).where("users.username like ?", '%'+search['value']+'%').order(arr[column.to_i]+' '+ direction);
@req=@req1.offset(start).limit(length)
else
@req1=Request.joins('LEFT JOIN users ON users.id= requests.userid').select('requests.*,users.username').where("uploaded_at >= :start_date AND uploaded_at <= :end_date",
  {start_date: @f, end_date: @t}).where(status: status).order(arr[column.to_i]+' '+ direction);
	@req=@req1.offset(start).limit(length)
	end



end
size= @req1.all.size
reqa=[]
reqasub=[]

@req.each do |s|
	rowid="r"+s.id.to_s
	body='<a href="/admin/user/body/'+s.id.to_s+'"><i class="fas fa-eye"></i></a>'
	csv=rails_blob_path(s.cfile, disposition: "attachment")
	csv1='<a href="'+csv+'"><i class="fas fa-file-download"></i></a>'
time=s.uploaded_at.strftime('%Y-%m-%d %H:%M:%S')

k=Reqsub.new(rowid,s.id,s.userid,User.find(s.userid).username,s.from,body,csv1,time,s.status,cols)
reqa.push(k)

end
return render json: {
	draw: draw,
	recordsTotal: size,
	recordsFiltered: size,
	data: reqa
}
	end
		def sret
start= params[:start]
length= params[:length]
draw= params[:draw]
search=params[:search]
order1= params[:order]
column= order1['0']['column']
cols= params[:columns]
direction=order1['0']['dir']
arr=['','id','page_name','sh_desc','status','sequence']
i=0

if(cols['4']['search']['value']!="")
if(cols['4']['search']['value']=='Active')
	i=1
end
if(search['value']!="")
@sub1=Sub.where(status: i).where("page_name like ?",  search['value']+'%').order(arr[column.to_i]+' '+ direction)
@sub=@sub1.offset(start).limit(length)
else
	@sub1=Sub.where(status:i).order(arr[column.to_i]+' '+ direction)
@sub=@sub1.offset(start).limit(length)
end
else
	if(search['value']!="")
@sub1=Sub.where("page_name like ?",  search['value']+'%').order(arr[column.to_i]+' '+ direction)
@sub=@sub1.offset(start).limit(length)
else
	@sub1=Sub.order(arr[column.to_i]+' '+ direction)
@sub=@sub1.offset(start).limit(length)
end
end
size= @sub1.all.size
data=[]
datasub=[]
@sub.each do |s|
	s1='Active'
	if(s.status==0)
		s1='Inactive'
	end
	e= '<a href="/admin/page/edit/'+s.id.to_s+'"><i class="fa fa-edit"></i></a>'
	
rowid= 't'+s.id.to_s
k=Datasub.new(rowid,s.id,s.page_name,s.sh_desc,s1,s.sequence,e)
data.push(k)
datasub=[]
end
return render json: {
	draw: draw,
	recordsTotal: size,
	recordsFiltered: size,
	data: data
}
	end
end
class Minisub
def initialize(rowid,to,sent,delivered,bounced,clicked,opened)
	@DT_RowId=rowid
	@to=to
	@sent=sent
	@delivered=delivered
	@bounced=bounced
	@clicked= clicked
	@opened= opened
end
end
class Homesub
	def initialize(rowid, userid, username,requestid ,from, sent ,delivered,bounced,clicked,opened,details)
		@DT_RowId=rowid
		@userid=userid
		@username= username
		@requestid=requestid
		@from= from
		@sent=sent
		@delivered=delivered
		@bounced= bounced
		@clicked= clicked
		@opened= opened
		@details= details
	end
	end
class Reqsub
	def initialize(rowid,id,userid,username,from,body,csv,uploaded_at,status,cols)
	@DT_RowId = rowid
		@id=id
		@Userid=userid
		@Username=username
		@from=from
		@body= body
		@csv= csv
		@uploaded_at= uploaded_at
		@status= status
		@cols=cols
		
	end
	end

class Datasub
def initialize(rowid,id,page_name,sh_desc,status,sequence,edit)

@id= id
@page_name =page_name
@sh_desc=sh_desc
@status= status
@sequence=sequence
@edit=edit

@DT_RowId = rowid
end
	end

	class Usrsub
def initialize(rowid,id,username,image)
	@DT_RowId=rowid
	@id=id
	@username=username
	@image=image
	end
end
end
end