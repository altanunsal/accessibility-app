class TripMailer < ApplicationMailer

  default from: 'trips@accessibuild.com'

  # IF the email is only being sent to one perseon, try looping this entire function instead of the internals
  def trip_email_start
    # Example until api calls have been ironed out
    # Also add address of destination to email
    @trip = params[:trip]
    @user = User.find(@trip.user_id)
    @recipients = @trip.contacts
    @recipients.each do |recipient|
      @recipient = recipient
      mail(
          to: @recipient.email,
          subject: "#{@user.first_name} has started their trip!"
      )
    end
  end

  def trip_email_end
    # @user = User.find(params:[:user_id])
    # @recipients = getIncludedContacts(params:[:trip_id])
    # @recipients.each do |recipient|
    #   mail(
    #       to: @recipient.email,
    #       subject: "#{@user.first_name} has arrived at their destination!"
    #     )
    # end
  end

  def trip_email_cancel
    # @user = User.find(params:[:user_id])
    # @recipients = getIncludedContacts(params:[:trip_id])
    # mail(
    #     to: @recipients.map(&:email).uniq,
    #     subject: "#{@user.first_name} has cancelled their trip!"
    #   )

  end

  private # Might remove if its easy to get contacts
    def getIncludedContacts(tripid)
      # Should return join table, but not individual contacts for now
      @contacts = Trip.find(tripid).companions
    end
end
