# frozen_string_literal: true

# Document JsonAPI response
class DocumentSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  set_type :document
  set_id :uuid

  attributes :owner_id, :name, :logo_url, :status, :data, :history, :updated_at,
             :created_at

  attribute :history do |object, params|
    object.history if params[:history].present?
  end
end
