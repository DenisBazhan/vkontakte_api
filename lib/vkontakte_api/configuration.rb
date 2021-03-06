require 'logger'

module VkontakteApi
  # General configuration module.
  # 
  # @note `VkontakteApi::Configuration` extends `VkontakteApi` so these methods should be called from the latter.
  module Configuration
    # Available options.
    OPTION_NAMES = [:app_id, :app_secret, :redirect_uri, :adapter, :faraday_options, :logger, :log_requests, :log_errors, :log_responses]
    
    attr_accessor *OPTION_NAMES
    
    alias_method :log_requests?,  :log_requests
    alias_method :log_errors?,    :log_errors
    alias_method :log_responses?, :log_responses
    
    # Default HTTP adapter.
    DEFAULT_ADAPTER = Faraday.default_adapter
    
    # Logger default options.
    DEFAULT_LOGGER_OPTIONS = {
      :requests  => true,
      :errors    => true,
      :responses => false
    }
    
    # A global configuration set via the block.
    # @example
    #   VkontakteApi.configure do |config|
    #     config.adapter = :net_http
    #     config.logger  = Rails.logger
    #   end
    def configure
      yield self if block_given?
      self
    end
    
    # Reset all configuration options to defaults.
    def reset
      @adapter         = DEFAULT_ADAPTER
      @faraday_options = {}
      @logger          = ::Logger.new(STDOUT)
      @log_requests    = DEFAULT_LOGGER_OPTIONS[:requests]
      @log_errors      = DEFAULT_LOGGER_OPTIONS[:errors]
      @log_responses   = DEFAULT_LOGGER_OPTIONS[:responses]
    end
    
    # When this module is extended, set all configuration options to their default values.
    def self.extended(base)
      base.reset
    end
  end
end
