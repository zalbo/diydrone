require 'dotenv'
Dotenv.load
require 'thingiverse'
require "net/http"

class HerokutokenController < ApplicationController

    def suck_tv_projects
      client_id = ENV['CLIEND_ID_FOR_HEROKU']
      client_secret = ENV['CLIENT_ID_FOR_HEROKU']

      redirect_to "https://www.thingiverse.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=https://diydrone.herokuapp.com/herokutoken/callback"

    end

    def callback

      client_id = ENV['CLIEND_ID_FOR_HEROKU']
      client_secret = ENV['CLIENT_ID_FOR_HEROKU']

      @tv = Thingiverse::Connection.new(client_id, client_secret, params[:code])

      Token.create(content:@tv.access_token)
    end
  end

end
