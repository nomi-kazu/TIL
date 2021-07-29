class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  wrap_parameters format: []

  def render_create_success
    render json: @resource, serializer: UserSerializer
  end

end