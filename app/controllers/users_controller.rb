class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]

  def index
    @users = User.all
  end

  def show
    @users = User.find(params[:id])
  end

  def new
    @users = User.new
  end

  def create
    @users = User.new(user)
    if @users.save
      session[:user_id] = @users.id
      redirect_to @users, notice: "Thank you for registering."
    else
      render :new
    end
  end

  def edit
    @users = User.find(params[:id])
  end

  def update
    @users = User.find(params[:id])
    if @users.update(user)
      redirect_to user_path(@users), notice: "Account successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @users = User.find(params[:id])
    @users.destroy
    session[:user_id] = nil
    redirect_to users_path, alert: "Account successfully deleted."
  end

  private

  def user
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
