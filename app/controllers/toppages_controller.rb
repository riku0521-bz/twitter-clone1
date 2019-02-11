class ToppagesController < ApplicationController
  def index
    if logged_in?
      @kadaipost = current_user.kadaiposts.build  # form_for 用
      @kadaiposts = current_user.kadaiposts.order('created_at DESC').page(params[:page])
    end
  end
end
