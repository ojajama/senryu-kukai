class InvitationsController < ApplicationController
  def show
    invitation = Invitation.find_by(token: params[:token], used_at: nil)
    if invitation
      session[:invitation_token] = params[:token]
      redirect_to complete_invitation_path(params[:token])
    else
      redirect_to root_path, alert: "招待リンクが無効または使用済みです。"
    end
  end

  def complete
    @invitation = Invitation.find_by(token: params[:token], used_at: nil)
    redirect_to root_path, alert: "招待リンクが無効または使用済みです。" unless @invitation
  end

  def register
    invitation = Invitation.find_by(token: params[:token], used_at: nil)
    unless invitation
      redirect_to root_path, alert: "招待リンクが無効または使用済みです。"
      return
    end

    user = User.new(
      email: invitation.email,
      password: invitation.initial_password,
      password_confirmation: invitation.initial_password,
      nickname: params[:nickname]
    )

    if user.save
      invitation.use!
      session.delete(:invitation_token)
      sign_in(user)
      redirect_to root_path, notice: "#{user.nickname} さん、ようこそ！"
    else
      @invitation = invitation
      @errors = user.errors
      render :complete, status: :unprocessable_entity
    end
  end
end
