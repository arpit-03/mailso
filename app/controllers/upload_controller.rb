class UploadController < ApplicationController
	  protect_from_forgery with: :null_session
IMAGE_EXT = [".gif", ".jpeg", ".jpg", ".png", ".svg"]

  def upload_image
    if params[:file]
      FileUtils::mkdir_p(Rails.root.join("public/uploads/files"))

      ext = File.extname(params[:file].original_filename)
      ext = image_validation(ext)
      file_name = "#{SecureRandom.urlsafe_base64}#{ext}"
      path = Rails.root.join("public/uploads/files/", file_name)

      File.open(path, "wb") {|f| f.write(params[:file].read)}
      view_file = Rails.root.join("/download_file/", file_name).to_s
      render :json => {:link => view_file}.to_json

    else
      render :text => {:link => nil}.to_json
    end
  end

  def image_validation(ext)
    raise "Not allowed" unless IMAGE_EXT.include?(ext)
  end

  def access_file
    if File.exists?(Rails.root.join("public", "uploads", "files", params[:name]))
      send_data File.read(Rails.root.join("public", "uploads", "files", params[:name])), :disposition => "attachment"
    else
      render :nothing => true
    end
  end
 
  VIDEO_EXT = [".mp4", ".webm", ".ogg"]

  def upload_video
    if params[:file]
      FileUtils::mkdir_p(Rails.root.join("public/uploads/files"))

      ext = File.extname(params[:file].original_filename)
      ext = video_validation(ext)
      file_name = "#{SecureRandom.urlsafe_base64}#{ext}"
      path = Rails.root.join("public/uploads/files/", file_name)

      File.open(path, "wb") {|f| f.write(params[:file].read)}
      view_file = Rails.root.join("/download_file/", file_name).to_s
      render :json => {:link => view_file}.to_json

    else
      render :text => {:link => nil}.to_json
    end
  end

  def video_validation(ext)
    raise "Not allowed" unless VIDEO_EXT.include?(ext)
  end

  def access_file
    if File.exists?(Rails.root.join("public", "uploads", "files", params[:name]))
      send_data File.read(Rails.root.join("public", "uploads", "files", params[:name])), :disposition => "attachment"
    else
      render :nothing => true
    end
  end
   FILE_EXT = [".txt", ".pdf", ".doc"]

  def upload_file
    if params[:file]
      FileUtils::mkdir_p(Rails.root.join("public/uploads/files"))

      ext = File.extname(params[:file].original_filename)
      ext = file_validation(ext)
      file_name = "#{SecureRandom.urlsafe_base64}#{ext}"
      path = Rails.root.join("public/uploads/files/", file_name)

      File.open(path, "wb") {|f| f.write(params[:file].read)}
      view_file = Rails.root.join("/download_file/", file_name).to_s
      render :json => {:link => view_file}.to_json

    else
      render :text => {:link => nil}.to_json
    end
  end

  def file_validation(ext)
    raise "Not allowed" unless FILE_EXT.include?(ext)
  end

  def access_file
    if File.exists?(Rails.root.join("public", "uploads", "files", params[:name]))
      send_data File.read(Rails.root.join("public", "uploads", "files", params[:name])), :disposition => "attachment"
    else
      render :nothing => true
    end
  end

end
