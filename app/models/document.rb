# frozen_string_literal: true

# Role embeded Data Model
class Document
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uuid
  # include Mongoid::Attributes::Dynamic
  include Mongoid::History::Trackable
  include DocumentStateMachine

  STATUS = %w[drafted received pending_approval pending_update rejected approved issued
              surrendered submitted void confirmed deleted generating].freeze

  field :owner_id, type: String
  field :document_type, type: String, default: :ebl
  field :name, type: String
  field :logo_url, type: String
  field :status, type: String, default: :drafted
  field :data, type: Hash, default: {}

  belongs_to :account
  embeds_many :permissions, inverse_of: :document

  validates :status, presence: true, inclusion: {
    in: STATUS,
    message: "%<value>s is not a valid status. Valid statuses: #{STATUS.map(&:downcase)}"
  }

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

  index updated_at: 1
  index created_at: 1

  scope :filter_by_user_id, lambda { |user_id|
    any_of(
      { :permissions.elem_match => { user_id: user_id } },
      { owner_id: user_id }
    )
  }
  scope :filter_by_status, ->(status) { where(status: status) }
  scope :filter_by_not_deleted, -> { where.not(status: :deleted) }

  def self.filter_by_user_id(user_id)
    any_of({ owner_id: user_id }, { permissions: { user_id: user_id } })
  end

  def self.fetch_all(options)
    build_options(options)
    documents = all
    documents = documents.filter_by_not_deleted unless @filter_status
    documents = documents.filter_by_status(@filter_status) if @filter_status
    documents
  end

  def self.build_options(options)
    @filter_status = options[:status]
  end
end
