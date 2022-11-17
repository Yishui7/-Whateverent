class PagesController < ApplicationController
  def home
  end

  def show
    @user = current_user
    @booking_requests = current_user.bookings
  end
end
