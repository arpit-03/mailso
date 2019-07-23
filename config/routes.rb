require 'resque/server'
Rails.application.routes.draw do
  get 'tarcker/index'
 namespace :api do
  
    namespace :v1 do
      get 'admin/home/m', to:'sub#shome', as: :api4
      get 'admin/page/m', to:'sub#sret', as: :api
      get 'admin/user/m',to:'sub#sreq', as: :api2
      get 'admin/useredit/m', to: 'sub#susr',as: :api3
      get 'admin/homemini/m/:id', to: 'sub#shomemini', as: :api5
      get 'user/email/u/:id',to: 'usersub#reqdetails',as: :api6
    end
  end
  mount Resque::Server.new, :at => "/resque"
  
  get 'admin/user/body/:id', to: 'admin#body', as: :body
  get 'admin/requests', to:'admin#requests', as: :requests
  post 'user/request', to:'user#createrequest', as: :create_request
  get 'user/emailcenter',to: 'user#emailcenter', as: :emailcenter
  get 'admin/index' , as: :root2
  get 'user/index', as: :root
  post 'admin/page/pagecreate2' , to: 'admin#pagecreate2' , as: :subs
  post 'admin/authorize', to: 'admin#authorize' , as: :admin
  get 'admin/user', to: 'admin#user', as: :user
  get 'admin/userdel', to:'admin#userdel', as: :userdel
  post 'admin/create', to: 'admin#create', as: :create_user
 get 'admin/useredit', to:'admin#useredit', as: :useredit
  get 'admin/error', to:'admin#error', as: :error
  get 'admin/page/pagecreate' , to: 'admin#pagecreate', as: :pg_create
  get 'user/login',to: 'user#login', as: :login
  post 'user/check', to: 'user#check' , as: :user1
  post 'user/change_index/:id' , to: 'user#change_index' , as: :change_index
  get 'admin/page', to: 'admin#page', as: :page
  get 'admin/page/edit/:id', to: 'admin#edit', as: :sub_edit
  post 'admin/page/update/:id' , to: 'admin#update', as: :sub_update
  get 'admin/page/delete' , to: 'admin#delete' , as: :sub_delete
  post 'admin/page/toggle/:id', to: 'admin#toggle' , as: :toggle
  get 'admin/page/active', to: 'admin#active', as: :active
  get 'admin/page/inactive', to: 'admin#inactive', as: :inactive
  get 'admin/page/changeindex', to: 'admin#changeindex' , as: :change_index3
  post 'admin/page/changeindex2', to: 'admin#changeindex2', as: :change_index2
  post 'user/logout', to: 'user#logout', as: :logout
  get 'admin/logout', to: 'admin#logout', as: :admin_logout
  post 'user/redirect/:id', to: 'user#redirect_to_index', as: :redirect_to_index
  # post 'admin/image_upload', to: 'admin#image_upload', as: :image_upload
  post "/upload_image" ,to: "upload#upload_image", as: :upload_image
get "/download_file/:name" ,to: "upload#access_file", as: :upload_access_file
post "/upload_file", to: "upload#upload_file", as: :upload_file
get "admin/mcancel", to:'admin#mcancel', as: :mcancel
post "/upload_video", to: "upload#upload_video", as: :upload_video
get 'admin/msend', to:'admin#msend', as: :msend 
get 'admin/mdel',to: 'admin#mdel',as: :mdel
post 'tarcker/webhooks', to: 'tarcker#webhooks1', as: :webhook
get 'tarcker/:id', to: 'tarcker#trackimage',as: :track_image
get 'admin/home', to: 'admin#home', as: :home
get 'tarcker/clicklink/:id', to:'tarcker#clicklink', as: :track_click
post 'admin/sign_out', to:"admin#sign_out",as: :sign_out
get 'user/email', to: 'user#mainemail', as: :email
get 'user/email/details/:id', to: 'user#reqdetails', as: :reqdet
get 'admin/req/details/:id', to: 'admin#adminreqdetails', as: :areqdet
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
