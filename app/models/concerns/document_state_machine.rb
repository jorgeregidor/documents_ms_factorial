# frozen_string_literal: true

# Handle states on work order
module DocumentStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    # pending started assigned rejected delivered
    aasm column: :status do
      state :drafted, initial: true
      state :received
      state :pending_approval
      state :pending_update
      state :rejected
      state :approved
      state :issued
      state :surrendered
      state :submitted
      state :void
      state :confirmed
      state :deleted
      state :generating

      # event :deliver do
      #   transitions from: :started, to: :delivered
      # end
    end
  end
end
