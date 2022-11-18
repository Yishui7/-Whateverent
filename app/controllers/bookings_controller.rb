class BookingsController < ApplicationController
  def index
    #array of gysm the user owns
    @users_gyms = current_user.gyms

    #all booking requests for a users gym
    @user_gym_booking_requests = []
    @users_gyms.each do |gym|
      @user_gym_booking_requests.push(gym.bookings)
    end
    @user_gym_booking_requests.flatten!

    #booking requests for the current users gyms divided by status
   @gym_bookings_pending = @user_gym_booking_requests.select do |booking|
     booking.status == "pending"
   end
   @gym_bookings_confirmed = @user_gym_booking_requests.select do |booking|
     booking.status == "confirmed"
   end
     @gym_bookings_rejected = @user_gym_booking_requests.select do |booking|
       booking.status == "rejected"
     end
    # @gym_bookings_cancelled = @user_gym_booking_requests.select do |booking|
    #   booking.status = "cancelled"
    # end

    #all booking requests by the current user
    @booking_requests = current_user.bookings

     #booking requests by the current user divided by status
     @user_bookings_pending = @booking_requests.select do |booking|
       booking.status == "pending"
     end
     @user_bookings_confirmed = @booking_requests.select do |booking|
     booking.status == "confirmed"
     end
     @user_bookings_rejected = @booking_requests.select do |booking|
     booking.status == "rejected"
    end
    # @user_bookings_cancelled = @booking_requests.select do |booking|
    # booking.status = "cancelled"
    # end
  end


  def create
    @gym = Gym.find(params[:gym_id])
    @booking = Booking.new(booking_params)
    @booking.duration = (@booking.end_time - @booking.start_time) / 3600
    @booking.total_price = @gym.price_per_hour * @booking.duration
    @booking.user = current_user
    @booking.status = "pending"
    @booking.gym = Gym.find(params[:gym_id])
    if @booking.save
      redirect_to bookings_path
    else
      render "gyms/show", status: :unprocessable_entity
    end
  end

  def edit
    @booking = Restaurant.find(params[:id])
  end

  def update
    @booking = Restaurant.find(params[:id])
    @booking.update(booking_params)
    redirect_to booking_path(@booking)
  end

  def accept
    @booking = Booking.find(params[:id])
    @booking.status = "confirmed"
    @booking.save!
    redirect_to bookings_path
  end

  def reject
    @booking = Booking.find(params[:id])
    @booking.status = "rejected"
    @booking.save!
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :start_time, :end_time, :clients)
  end

  def user_params
    params.require(:user).permit(:active)
  end
end
