module Admin
  class InvitationsController < BaseController
    def index
      @invitations = Invitation.order(created_at: :desc)
      @invitation = Invitation.new
    end

    def create
      @invitation = Invitation.new(invitation_params)
      if @invitation.save
        redirect_to admin_invitations_path, notice: "招待リンクを発行しました。"
      else
        @invitations = Invitation.order(created_at: :desc)
        render :index, status: :unprocessable_entity
      end
    end

    private

    def invitation_params
      params.require(:invitation).permit(:email, :initial_password)
    end
  end
end
