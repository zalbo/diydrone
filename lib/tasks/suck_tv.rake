require 'dotenv'
Dotenv.load


namespace :suck_tv do

  desc "Create Tag for search"
  task :create_tag => :environment do

    showtags

    puts "Write the tags that you want to insert"
    ask = STDIN.gets.chomp.to_s
    unless ask == ""
      TagsSuckTv.create(tag: ask)
      puts "the tag ...#{ask}... is inserited"
    else
      puts "error write tag"
    end
  end

  desc "Delete Tag"
  task :delete_tag => :environment do

    showtags

    puts "write the number of tag that do you want delete, or all for delete all tag"
    ask = STDIN.gets.chomp.to_s
    if ask == "all"
      TagsSuckTv.all.destroy_all
      puts "All Cancelled"
    else
      TagsSuckTv.delete(ask)
      puts "done"
    end
  end

  desc "Suck project of Thinghiverse"
  task :suck => :environment do
    tags = TagsSuckTv.all
    tags.each do |tag|
      if tag.tag.include? " "
        tag.tag = tag.tag.gsub!(' ', '%20')
      end

      token = Token.first.content
      page = 1
      tv_id= []

      Drone.all.each do |project_db|
        tv_id << project_db.tv_id.to_s
      end

      while Net::HTTP.get(URI("https://api.thingiverse.com/search/#{tag.tag}/?access_token=#{token}&page=#{page.to_s}")) != "{\"error\":\"Not Found\"}"
        res = formatjson("https://api.thingiverse.com/search/#{tag.tag}/?access_token=#{token}&page=#{page.to_s}")
        res.each do |project|
          if tv_id.include? project["id"]
            puts "ALERT:: #{project["name"]} is already in the database"
          else
            project_detail = formatjson("#{project["url"]}?access_token=#{token}")
            if project_detail["default_image"] == nil
              puts "ALERT:: #{project["name"]}is empty"
            else
              Drone.create(title: project["name"], user: project["creator"]["name"], tv_id: project["id"], tv_image: project_detail["default_image"]["sizes"])
              puts "OK:: #{project["name"]} insert"
            end
          end
        end
        page += 1
        puts "next #{page}..."
      end
      puts "done trasfert"
    end
  end

  desc "Delete Tolken"
  task :delete_tolken => :environment do
    Token.all.each do |token|
      token.destroy
    end
  end
end

def formatjson(link_api)
  uri = URI(link_api)
  body = Net::HTTP.get(uri)
  return JSON.parse(body)
end

def showtags
  tags = TagsSuckTv.all

  if tags.empty?
    puts "There aren't tag"
  else
    puts "the tags are:"
    tags.each do |tag|
      puts """#{tag.id}: #{tag.tag}
"""
    end
  end
end
