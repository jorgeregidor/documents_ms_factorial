# frozen_string_literal: true

class Snippet
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uuid
  # include Mongoid::Attributes::Dynamic
  include Mongoid::History::Trackable

  field :input_key, type: String
  field :input_value, type: String

  embedded_in :account, inverse_of: :snippets

  track_history on: %i[fields],
                modifier_field: :nil,
                modifier_field_inverse_of: :nil,
                modifier_field_optional: true,
                version_field: :version,
                track_create: true,
                track_update: true,
                track_destroy: true

  index updated_at: 1
  index created_at: 1
end
