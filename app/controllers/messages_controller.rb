class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def getsms
    message_body = params["Body"]
    from_number = params["From"]

    puts "RECEIVED AN SMS NUMBER..."
    puts "FROM: #{from_number}"
    puts message_body

    # trim phone number
    from_number.remove!("+");
    from_number.remove!(" ");
    from_number.remove!("-");
    from_number.remove!("(");
    from_number.remove!(")");
    if from_number.start_with?("1")
      from_number[0] = ''
    end

    user = User.where(["phone_number = ?", phone_number]).first # by phone number

    puts "FROM NUMBER CONVERTED TO : #{from_number}"
    puts "USER : #{user.name}"

    # build new track
    track = Track.new
    track.posted_by_id = user.id
    track.team_id = user.team_id

    urls = message_body.scan(/(https?:\/\/([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)/)
    url = urls[0][0]

    puts "URL found: #{url}"

    track.url = url      # need to trim out URL from everything else

    resource = OEmbed::Providers.get(track.url)
    if !resource.title.empty?
      track.embed_html = resource.html.html_safe
      track.thumbnail =resource.thumbnail_url
      if track.title.empty?
        track.title = resource.title
      end
    end

    if track.save
      # response text?... no
      puts "TRACK SAVED"
    else
      puts "TRACK NOT SAVED..wth"
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
