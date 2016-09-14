require 'active_support/configurable'

module Alidns

  class << self
    # Configures global settings for Rongcloud
    #   Rongcloud.configure do |config|
    #     config.app_key = 10
    #   end
    def configure(&block)
      yield @config ||= Alidns::Configuration.new
    end

    # Global settings for Rongcloud
    def config
      @config
    end
  end

  class Configuration  #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :app_key, :app_secret, :host, :log_file, :log_level, :response_format
  end

  # this is ugly. why can't we pass the default value to config_accessor...?
  configure do |config|
    config.app_key = ''
    config.response_format = 'json'
    config.app_secret = ''
    config.host = 'https://alidns.aliyuncs.com'
    config.log_file = ''
    config.log_level = :warn
  end
end
