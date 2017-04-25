# frozen_string_literal: true

require 'surf/utils/configurationable'
require 'surf/registry'

module Surf
  class PingWebhookSaver
    extend Configurationable

    cattr_accessor :repositroy_class, Surf::Registry.repositroy_class
    cattr_accessor :storage

    def initialize(context)
      @context = context
    end

    def call
      repository = self.class.repositroy_class.new(context.raw_body)
      self.class.storage.save(id: repository.id, value: context.raw_body)
    end

    private

    attr_reader :context
  end
end
