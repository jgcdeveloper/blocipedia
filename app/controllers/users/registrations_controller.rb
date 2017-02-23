class Users::RegistrationsController < Devise::RegistrationsController
  def downgrade
    downgrade_posts
    current_user.downgrade_user
    flash[:notice] = 'Downgrade Complete'
    redirect_to(:back)
  end

  private

  def downgrade_posts
    current_user.wikis.all.each do |wiki|
      wiki.update(private: false)
    end
  end
end
