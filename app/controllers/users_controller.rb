class UsersController < ApplicationController
  before_action :find_user_by_id, only: %i(show edit update destroy)
  before_action :logged_in_user, only: %i(index show edit update destroy)
  before_action :correct_user, only: %i(show edit update)
  before_action :admin_user, only: :destroy

  def edit; end

  def index
    @pagy, @users = pagy User.activated, items: Settings.page_items
  end

  def show
    @pagy, @microposts = pagy @user.microposts, items: Settings.page_items
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_activation_mail"
      redirect_to root_path
      return
    end

    render :new, status: :unprocessable_entity
  end

  def update
    if @user.update user_params
      flash[:success] = t ".success"
      redirect_to @user
      return
    end

    render :edit, status: :unprocessable_entity
  end

  def destroy
    @user.destroy
    flash[:success] = t ".success"
    redirect_to users_url, status: :see_other
  end

  private

  def user_params
    params.require(:user).permit User::SIGN_UP_PARAMS
  end

  def find_user_by_id
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t "users.not_found"
    redirect_to root_path
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = t "users.unauthorized"
    redirect_to current_user, status: :see_other
  end

  def admin_user
    redirect_to root_url, status: :see_other unless current_user.admin?
  end
end
