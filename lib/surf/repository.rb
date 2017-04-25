# frozen_string_literal: true

require 'json'
require 'surf/utils/mappingable'
require 'surf/registry'

module Surf
  class Repository
    include Mappingable

    cattr_accessor :pull_request_class, Surf::Registry.pull_request_class

    def initialize(webhook_body)
      @webhook_body = JSON.parse(webhook_body)
      create_mapping(@webhook_body)
    end

    def pull_request(id)
      self.class.pull_request_class.new(self, id)
    end

    attr_reader :webhook_body
  end
end
