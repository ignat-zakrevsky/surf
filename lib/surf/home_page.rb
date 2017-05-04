# frozen_string_literal: true

require 'json'
require 'rack'
require 'surf/utils/http_route'
require 'erb'

TEMPLATE = %{
<html>
  <head>
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700"
      rel="stylesheet" type="text/css">
    <style>
      body {
        background-color: #f1f1f1;
      }

      .logo {
        font-size: 7em;
        text-align: center;
        padding-top: 7rem;
        padding-bottom: 0rem;
        margin-bottom: 1rem;
      }

      .welcome {
        font-family: 'Lato', Arial, sans-serif;
        font-size: 3rem;
        text-align: center;
        padding-top: 0rem;
        margin-top: 1rem;"
      }
    </style>
  </head>
  <body>
    <p class="logo">🏄</p>
    <p class="welcome">Hello, <%= request.session[:user].dig('info', 'name') %></p>
  </body>
</html>
}

module Surf
  class HomePage < HttpRoute
    include ERB::Util

    cattr_accessor(:route, %w[GET /home])

    def call
      return response.tap { |r| r.redirect('/auth/github') } unless authenticated?
      response.body = [ERB.new(TEMPLATE).result(binding)]
      response[Rack::CONTENT_TYPE] = 'text/html; charset=UTF-8'
      response
    end

    def authenticated?
      !request.session[:user].nil?
    end
  end
end
