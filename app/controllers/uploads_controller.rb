class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :update, :destroy]
  before_action :load_drone

  def load_drone
    @drone = Drone.find(params[:drone_id])
  end

  # GET /uploads
  # GET /uploads.json
  def index

    @uploads = @drone.uploads
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create

    @upload = Upload.create(upload_params)
    @drone.uploads << @upload

    file = @upload.uploaded_file_file_name
    povfile = file.sub '.stl' , '.pov'
    pngfile = file.sub '.stl' , '.png'
    url = "#{Rails.root.to_s}/tmp"
    system("cp #{@upload.uploaded_file.path} #{url}")
    system(" /usr/local/bin/stl2pov-master/stl2pov  #{url}/#{file} >  #{url}/#{povfile}")
    system("povray +I#{url}/#{povfile} +O#{url}/#{pngfile} +D +P +W640 +H480 +A0.5")

 @drone.uploads << Upload.new(uploaded_file: File.open("#{url}/#{pngfile}", 'rb'))


    @drone.update(image: @drone.id)
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    respond_to do |format|
      if @upload.update(upload_params)
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
      params[:upload].permit(:uploaded_file)
    end
end
