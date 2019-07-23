class TarckerController < ApplicationController
skip_before_action :verify_authenticity_token
  def index
  
  end
  	def trackimage
    puts(params[:id])
 i=params[:id]
 Emailstatus.find(i).update(opened: true ,opened_at: Time.now.strftime('%Y-%m-%d %H:%M:%S'))
file_path =File.join(Rails.root, "app", "assets", "images", "p.png")
send_file(file_path, type: 'image/png')
  end
  def clicklink
 i=params[:id]
  Emailstatus.find(i).update(clicked: true ,clicked_at: Time.now.strftime('%Y-%m-%d %H:%M:%S'))
  redirect_to root_path
  end
   def webhooks1
   
data= JSON.parse(request.body.read())
data.each do |d|
if(d["event"]=="bounce")
Emailstatus.find(d["emailstatusid"]).update(bounced: true , bounced_at: Time.now.strftime('%Y-%m-%d %H:%M:%S'))
end
end


end

  
end
