# frozen_string_literal: true

# Document JsonAPI response
class SnippetSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  set_type :snippet
  set_id :uuid

  attributes :input_key, :input_value

  attribute :history do |object, params|
    object.history if params[:history].present?
  end
end
