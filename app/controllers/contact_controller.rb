class ContactController < ApplicationController

  def index
  end

  def create
    @params = params
    ContactNotifier.send_contact_email(@params).deliver
    flash[:success] = 'Email Sent!'
    redirect_to contact_index_path
  end

end
