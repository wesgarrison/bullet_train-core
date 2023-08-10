module Account::Onboarding::InvitationLists::ControllerBase
  extend ActiveSupport::Concern

  included do
    layout "devise"
    load_and_authorize_resource class: "User"
    load_and_authorize_resource class: "Team"

    before_action do
      @user = current_user
      @team = current_team
    end
  end

  def new
    @invitation_list = Account::Onboarding::InvitationList.new
  end

  # We don't actually create a InvitationList record here,
  # it's simply a placeholder to generate new invitations.
  def create
    # TODO: Send invitations here.
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def strong_params
    params.permit(:invitation_list).require(
      :team,
      :creator_membership_id,
      invitations_attributes: [
        :email,
        # TODO: Membership
      ]
    )
  end
end
