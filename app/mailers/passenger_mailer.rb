class PassengerMailer < ApplicationMailer

  def thank_you_email
    @passenger = params[:passenger]
    @booking = params[:booking]
    @url = booking_url(@booking)
    mail(to: @passenger.email,
         subject: 'You have booked your ticket.')
  end
end
