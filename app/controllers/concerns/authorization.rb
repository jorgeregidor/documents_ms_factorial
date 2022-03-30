# frozen_string_literal: true

module Authorization
  def current_user
    @current_user ||= build_current_user
  end

  def build_current_user
    @oauth_user_info ||= request.env['HTTP_USER_INFO']
    return forbidden if @oauth_user_info.blank?

    @current_user = OpenStruct.new(user_to_hash_object['data'])
  end

  def user_to_hash_object
    JSON.parse(@oauth_user_info)
  end
end
