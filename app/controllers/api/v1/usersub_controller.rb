module Api 
	module V1 
		class UsersubController< ApplicationController 
			def reqdetails
				userid=params[:id]
				draw= params[:draw] 
start= params[:start] 
length= params[:length]
search=params[:search]
 order1= params[:order] 
 cols= params[:columns]
 status=cols["5"]["search"]['value']
date=cols['4']['search']['value']
 column=order1['0']['column'] 
 direction=order1['0']['dir'] 
 arr=["","id","requests.from","count","uploaded_at","status","sent_at"]
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


 i=0

if(status=="")
if(column["value"]=="")
 if(search["value"]=="")
@usertable1= Request.where(userid: userid).where("uploaded_at >= :start_date AND uploaded_at < :end_date",
  {start_date: @f, end_date: @t})
@usertable=@usertable1.offset(start).limit(length)
else
	@usertable1= Request.where(userid: userid).where('requests.from like ?' ,"%"+search['value']+"%")..where("uploaded_at >= :start_date AND uploaded_at < :end_date",
  {start_date: @f, end_date: @t})
	@usertable=@usertable1.offset(start).limit(length)
end	

elsif (arr[column.to_i]=="count")
	i=1
puts i
 if(search["value"]=="")
@usertable1= Emailstatus.select("COUNT(request_id) AS count ,  request_id,requests.id,requests.from,requests.uploaded_at,requests.status").group("request_id").order(arr[column.to_i]+" "+direction).joins("LEFT JOIN requests ON requests.id=request_id WHERE userid ="+userid)..where("uploaded_at >= :start_date AND uploaded_at < :end_date",
  {start_date: @f, end_date: @t})
@usertable=@usertable1.offset(start).limit(length)
else
	@usertable1= Emailstatus.select("COUNT(request_id) AS count ,  request_id,requests.id,requests.from,requests.uploaded_at,requests.status").group("request_id").order(arr[column.to_i]+" "+direction).joins("LEFT JOIN requests ON requests.id=request_id WHERE userid ="+userid+" AND requests.from like " ,'"%'+search['value']+'%"')..where("uploaded_at >= :start_date AND uploaded_at < :end_date",
  {start_date: @f, end_date: @t})
	@usertable=@usertable1.offset(start).limit(length)

end	
	
else
 if(search["value"]=="")
@usertable1= Request.where(userid: userid).where("uploaded_at >= :start_date AND uploaded_at < :end_date",
  {start_date: @f, end_date: @t}).order(arr[column.to_i]+" "+direction)
@usertable=@usertable1.offset(start).limit(length)
else
	@usertable1= Request.where(userid: userid).where('requests.from like ?' ,"%"+search['value']+"%").where("uploaded_at >= :start_date AND uploaded_at < :end_date",
  {start_date: @f, end_date: @t}).order(arr[column.to_i]+" "+direction)
@usertable=@usertable1.offset(start).limit(length)
end	
	end
else
	if(column["value"]=="")
 if(search["value"]=="")
@usertable1= Request.where(userid: userid,status:status).where("uploaded_at >= :start_date AND uploaded_at < :end_date",
  {start_date: @f, end_date: @t})

@usertable=@usertable1.offset(start).limit(length)
else
	@usertable1= Request.where(userid: userid,status:status).where('requests.from like ?' ,"%"+search['value']+"%")..where("uploaded_at >= :start_date AND uploaded_at < :end_date",
  {start_date: @f, end_date: @t})
	@usertable=@usertable1.offset(start).limit(length)
end	

elsif (arr[column.to_i]=="count")
	i=1
puts i
 if(search["value"]=="")
@usertable1= Emailstatus.select("COUNT(request_id) AS count ,  request_id,requests.id,requests.from,requests.uploaded_at,requests.status").group("request_id").order(arr[column.to_i]+" "+direction).joins("LEFT JOIN requests ON requests.id=request_id WHERE userid ="+userid).where("uploaded_at >= :start_date AND uploaded_at < :end_date",
  {start_date: @f, end_date: @t}).where(status: status)
@usertable=@usertable1.offset(start).limit(length)
else
	@usertable1= Emailstatus.select("COUNT(request_id) AS count ,  request_id,requests.id,requests.from,requests.uploaded_at,requests.status").group("request_id").order(arr[column.to_i]+" "+direction).joins("LEFT JOIN requests ON requests.id=request_id WHERE userid ="+userid+" AND requests.from like " ,'"%'+search['value']+'%"')..where("uploaded_at >= :start_date AND uploaded_at < :end_date",
  {start_date: @f, end_date: @t}).where(status: status)
	@usertable=@usertable1.offset(start).limit(length)

end	
	
else
 if(search["value"]=="")
@usertable1= Request.where(userid: userid,status:status).where("uploaded_at >= :start_date AND uploaded_at < :end_date",
  {start_date: @f, end_date: @t}).order(arr[column.to_i]+" "+direction)
@usertable=@usertable1.offset(start).limit(length)
else
	@usertable1= Request.where(userid: userid,status:status).where('requests.from like ?' ,"%"+search['value']+"%").where("uploaded_at >= :start_date AND uploaded_at < :end_date",
  {start_date: @f, end_date: @t}).order(arr[column.to_i]+" "+direction)
@usertable=@usertable1.offset(start).limit(length)
end	
	end
end
usert=[]
size=@usertable1.size
@usertable.each do |u|
	rowid= "r"+u.id.to_s
	det="<a href='/user/email/details/"+u.id.to_s+"'><i class='fas fa-search-plus'></i></a>"

	utime=u.uploaded_at.strftime('%Y-%m-%d %H:%M:%S')
	if i==0
k= Usermain.new(rowid,u.id,u.from,Emailstatus.where(request_id: u.id).size,utime,u.status,det)
	else
		k= Usermain.new(rowid,u.id,u.from,u.count,utime,u.status,det)
	end
	usert.push(k)
	end
return render json: {
	draw: draw,
	recordsTotal: size,
	recordsFiltered: size,
	data: usert
}

			end
		end
		class Usermain
def initialize(rowid,id,from,count,rat,status,det)
	@DT_RowId=rowid
	@id=id
	@from=from
	@count= count
	@rdate=rat
	@status=status
	
	@details= det
end
		end
	end
end