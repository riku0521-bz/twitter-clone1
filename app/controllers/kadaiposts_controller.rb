class KadaipostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @kadaipost = current_user.kadaiposts.build(kadaipost_params)
    if @kadaipost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @kadaiposts = current_user.kadaiposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @kadaipost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def kadaipost_params
    params.require(:kadaipost).permit(:content)
  end
  
  def correct_user
    @kadaipost = current_user.kadaiposts.find_by(id: params[:id])
    unless @kadaipost
      redirect_to root_url
    end
  end
end