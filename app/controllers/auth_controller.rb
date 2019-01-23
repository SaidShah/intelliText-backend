class AuthController < ApplicationController

def show

  user=User.find(JWT.decode(request.authorization, "mySecret")[0]["user_id"])
  render json: {user: user, jwt: request.authorization}
end



def create
  user=User.find_by(username: auth_params[:uesrname])
  if user && user.authenticate(user_params[:password])
    token = JWT.encode({user_id: user.id}, "mySecret")
    render json: {user: user, jwt: token}
  else
    render json: {user: {}},status: 422
  end

end


private

def auth_params
  params.require(:auth).permit(:username,:password)
end


end
