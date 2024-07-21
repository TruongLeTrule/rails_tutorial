class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    return handle_invalid_user if @user.nil?

    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.turbo_stream
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    return handle_invalid_user if @user.nil?

    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @user, status: :see_other}
      format.turbo_stream
    end
  end

  private

  def handle_invalid_user
    flash[:danger] = t "relationships.invalid_user"
    redirect_to root_path
  end
end
