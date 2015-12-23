class ContactNotifier < ActionMailer::Base
  default from: "registration@oceanareaconvention.org"
  mail_to = ENV['MAIL_TO_ADDRESS']

  def send_contact_email(params)
    @params = params
    mail(:to => mail_to, :subject => @params[:type] + 'contact request')
  end

end
