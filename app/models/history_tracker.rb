# frozen_string_literal: true

# Alows to track history
class HistoryTracker
  include Mongoid::History::Tracker
end
