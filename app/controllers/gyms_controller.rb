class GymsController < ApplicationController

  def index
    @gyms = Gym.all
  end

  def show
    @gym  = Gym.find(params[:id])
  end

  def new
    @gym = Gym.new
  end

  def create
    @gym = Gym.new(gym_params)
    @gym.user = current_user
    if @gym.save
      redirect_to(@gym)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end


  private

  def gym_params
    params.require(:gym).permit(:price, :address, :name, :category, :capacity, :description)
  end
end
