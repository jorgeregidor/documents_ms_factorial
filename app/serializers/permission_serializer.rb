# frozen_string_literal: true

# Document JsonAPI response
class PermissionSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  set_type :permission
  set_id :uuid

  attributes :user_id, :read, :write, :updated_at, :created_at

  attribute :history do |object, params|
    object.history if params[:history].present?
  end
end
