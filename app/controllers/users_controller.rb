class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def create
    user = User.create(user_params)
    if user.valid?
      token = JWT.encode({user_id: user.id}, "theSecret")
      render json: {user: user, jwt: token}
    else
      render json{error: "CANT CREATE USER"},status:422
    end

    private

    def user_params
      params.require(:user).permit(:first_name,:last_name,:username,:password)
    end

  end


end
