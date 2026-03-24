class ApplicationController < ActionController::API
  before_action :authorize_request

  

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    begin
      decoded = JwtService.decode(token)
      @current_user = User.find(decoded["user_id"])
    rescue
      render json: { error: 'Unauthorized' }, status: 401
    end
  end

end
