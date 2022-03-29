# frozen_string_literal: true

module LoggerHelper
  def self.app_method_info(class_name = nil, method_name = nil)
    "::#{class_name}##{method_name}"
  end
end
