
class DronesController < ApplicationController
  before_action :set_drone, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: ['index', 'show']

  # GET /drones
  # GET /drones.json
  def index
    @drones = Drone.all
  end

  # GET /drones/1
  # GET /drones/1.json
  def show
    if @drone.fromtv
      @first_image = @drone.image[12]
    end

    @drone.uploads.each do |file|
      if file.is_image_type?
        if @first_image == nil
          @first_image = file.uploaded_file.url(:large)
        end
      end
    end

    @first_image
  end

  # GET /drones/new
  def new
    @drone = Drone.new
  end

  # GET /drones/1/edit
  def edit
  end

  # POST /drones
  # POST /drones.json
  def create

    @drone = Drone.new(drone_params)




    respond_to do |format|
      if @drone.save

        format.html { redirect_to "/drones/#{@drone.id}/uploads/new", notice: 'Drone was successfully created.' }
        format.json { render :show, status: :created, location: @drone }
      else
        format.html { render :new }
        format.json { render json: @drone.errors, status: :unprocessable_entity }
      end
    end
  end



  # PATCH/PUT /drones/1
  # PATCH/PUT /drones/1.json
  def update
    @drone.file_projects.create(:uploaded_file => params[:upload][:uploaded_file])
     redirect_to drones_url
  end

  # DELETE /drones/1
  # DELETE /drones/1.json
  def destroy
    @drone.destroy
    respond_to do |format|
      format.html { redirect_to drones_url, notice: 'Drone was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drone
      @drone = Drone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drone_params

      params.require(:drone).permit(:title, :user )
    end
end
