class SessionsController < ApplicationController
  before_action :find_user_by_email, only: [:create]

  def create
    unless @user&.authenticate(params.dig(:session, :password))
      flash.now[:danger] = t ".invalid"
      return render :new, status: :unprocessable_entity
    end

    params.dig(:session, :remember_me) == "1" ? remember(@user) : forget(@user)
    log_in @user
    flash[:success] = t ".successful"
    redirect_to @user
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end

  private

  def find_user_by_email
    @user = User.find_by(email: params.dig(:session, :email)&.downcase)
  end
end
