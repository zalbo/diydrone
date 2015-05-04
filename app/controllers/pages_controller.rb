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

    puts "What do you want to insert into db?"

    @word_search = gets.chomp.to_s
    @tv = Thingiverse::Connection.new(client_id, client_secret, params[:code])
    @page = 1
    while Net::HTTP.get(URI("https://api.thingiverse.com/search/#{@word_search}/?access_token=#{@tv.access_token}&page=#{@page.to_s}")) != "{\"error\":\"Not Found\"}"
      uri = URI("https://api.thingiverse.com/search/#{@word_search}/?access_token=#{@tv.access_token}&page=#{@page.to_s}")
      body = Net::HTTP.get(uri)
      res = JSON.parse(body)
      res.each do |project|
        Drone.create(title: project["name"], tv_user: project["creator"]["name"])
      end
      @page += 1
      puts "next #{@page}..."
    end
    redirect_to "http://localhost:3000"
  end
end
