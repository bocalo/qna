class ConfirmationsController < Devise::ConfirmationsController
  def create
    email = user_params[:email]
    password = Devise.friendly_token[0, 20]

    @user = User.new(email: email,
                    password: password,
                    password_confirmation: password)

    if @user.save
      @user.send_confirmation_instructions
      redirect_to root_path, notice: 'Confirm your email'
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
