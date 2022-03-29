# frozen_string_literal: true

# Permission embeded Data Model
class Permission
  include Mongoid::Document
  include Mongoid::Timestamps

  include Mongoid::Uuid
  # include Mongoid::Attributes::Dynamic
  include Mongoid::History::Trackable

  field :read, type: Boolean, default: true
  field :write, type: Boolean, default: false
  field :user_id, type: String

  embedded_in :document, inverse_of: :permissions

  # dynamic fields will be tracked automatically
  # https://github.com/mongoid/mongoid-history
  track_history on: %i[fields],
                modifier_field: :nil,
                modifier_field_inverse_of: :nil,
                modifier_field_optional: true,
                version_field: :version,
                track_create: true,
                track_update: true,
                track_destroy: true

  validates_uniqueness_of :user_id

  index updated_at: 1
  index created_at: 1
end
