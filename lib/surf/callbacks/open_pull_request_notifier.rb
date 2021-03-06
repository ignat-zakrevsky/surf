# frozen_string_literal: true

require 'surf/github/issue_messenger'
require 'surf/callbacks/pull_request_logger'

module Surf
  class OpenPullRequestNotifier < PullRequestLogger
    extend Configurable

    cattr_accessor(:messenger_class) { Surf::IssueMessenger }

    def call
      messenger.comment(I18n.t('surf.webhooks.catched'), strategy: :add_to_first)
    end

    def messenger
      self.class.messenger_class.new(webhook.repository, webhook.pull_request.id)
    end
  end
end
