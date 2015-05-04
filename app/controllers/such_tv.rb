require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'pry'
require 'thingiverse'
require "net/http"
require 'dotenv'
Dotenv.load


client_id = ENV['CLIENT_ID']
client_secret = ENV['CLIENT_SECRET']
get "/" do
  redirect("http://localhost:4567/auth")
end

get "/auth" do
  redirect("https://www.thingiverse.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=http://localhost:4567/callback")
end

get "/callback" do
  puts "What do you want to insert into db?"
  @word_search = gets.chomp.to_s
  @tv = Thingiverse::Connection.new(client_id, client_secret, params[:code])
  @page = 1
  while Net::HTTP.get(URI("https://api.thingiverse.com/search/#{@word_search}/?access_token=#{@tv.access_token}&page=#{@page.to_s}")) != "{\"error\":\"Not Found\"}"
    uri = URI("https://api.thingiverse.com/search/#{@word_search}/?access_token=#{@tv.access_token}&page=#{@page.to_s}")
    body = Net::HTTP.get(uri)
    res = JSON.parse(body)
    open('droneproject.txt', 'a') do |f|
      res.each do |project|
        binding.pry
        f << project["name"]
      end
      @page += 1
      puts "next #{@page}..."
    end

  end
  puts "finisch"
end
