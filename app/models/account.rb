# frozen_string_literal: true

class Account
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uuid
  # include Mongoid::Attributes::Dynamic
  include Mongoid::History::Trackable

  field :owner_id, type: String

  embeds_many :snippets
  has_many :documents

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

  validates_uniqueness_of :owner_id

  def self.by_user_id(user_id)
    find_by(owner_id: user_id) || create(owner_id: user_id)
  end
end
