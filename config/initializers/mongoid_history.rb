# frozen_string_literal: true

# config/initializers/mongoid_history.rb
# initializer for mongoid-history
# assuming HistoryTracker is your tracker class
Mongoid::History.tracker_class_name = :history_tracker