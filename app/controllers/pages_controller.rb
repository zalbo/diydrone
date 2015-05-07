require 'dotenv'
Dotenv.load
require 'thingiverse'
require "net/http"


class PagesController < ApplicationController


  def suck_tv_projects
    client_id = ENV['CLIENT_ID']
    client_secret = ENV['CLIENT_SECRET']

    redirect_to "https://www.thingiverse.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=http://localhost:3000/pages/callback"

  end

  def callback

    client_id = ENV['CLIENT_ID']
    client_secret = ENV['CLIENT_SECRET']

    @tv = Thingiverse::Connection.new(client_id, client_secret, params[:code])

    Token.create(content:@tv.access_token)
    redirect_to "http://localhost:3000"
  end
end
