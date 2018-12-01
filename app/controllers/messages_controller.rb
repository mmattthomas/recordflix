class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def getsms
    message_body = params["Body"]
    from_number = params["From"]

    puts "RECEIVED AN SMS NUMBER..."
    puts "FROM: #{from_number}"
    puts message_body

    track = Track.new(track_params)

    # trim phone number

    user = User.find() # by phone number

    track.posted_by_id = user.id
    track.team_id = user.team_id
    track.url = message_body      # need to trim out URL from everything else

    resource = OEmbed::Providers.get(track.url)
    if !resource.title.empty?
      track.embed_html = resource.html.html_safe
      track.thumbnail =resource.thumbnail_url
      if track.title.empty?
        track.title = resource.title
      end
    end

    if track.save
      # response text?
    else
      # log error?
    end 


    # for replies, this is used

    #boot_twilio
    # sms = @client.messages.create(
    #   from: Rails.application.secrets.twilio_number,
    #   to: from_number,
    #   body: "Hello there, thanks for texting me. Your number is #{from_number}."
    # )

  end

  private

  def track_params
    params.require(:track).permit(:title, :description, :likes, :comments, :url, :posted_by_id, :team_id)
  end

  def boot_twilio
    account_sid = Rails.application.secrets.twilio_sid
    auth_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

end
