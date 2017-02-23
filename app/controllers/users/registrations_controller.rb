class Users::RegistrationsController < Devise::RegistrationsController
  def downgrade
    current_user.downgrade_user
    flash[:notice] = "Downgrade Complete"
    redirect_to(:back)
  end
end
