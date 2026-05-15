class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        invitation = Invitation.find_by(token: session[:invitation_token], used_at: nil)
        invitation&.use!
        session.delete(:invitation_token)
      end
    end
  end
end
