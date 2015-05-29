module Calabash
  # Contains the iOS implementations of the Calabash APIs.
  module IOS
    require 'calabash'
    include Calabash

    # @!visibility private
    def self.extended(base)
      Calabash.send(:extended, base)
    end

    # @!visibility private
    def self.included(base)
      Calabash.send(:included, base)
    end

    require 'calabash/ios/device/runtime_attributes'
    require 'calabash/ios/device/routes/error'
    require 'calabash/ios/device/routes/handle_route_mixin'
    require 'calabash/ios/device/routes/map_route_mixin'
    require 'calabash/ios/device/routes/uia_route_mixin'

    require 'calabash/ios/device/gestures_mixin'

    require 'calabash/ios/device/status_bar_mixin'

    require 'calabash/ios/environment'
    require 'calabash/ios/device/physical_device_mixin'
    require 'calabash/ios/device/device'
    require 'calabash/ios/operations'
    require 'calabash/ios/server'
    require 'calabash/ios/application'

    include Calabash::IOS::Operations
  end
end
