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
      id= []

      Drone.all.each do |project_db|
        id << project_db.id.to_s
      end

      while Net::HTTP.get(URI("https://api.thingiverse.com/search/#{tag.tag}/?access_token=#{token}&page=#{page.to_s}")) != "{\"error\":\"Not Found\"}"
        res = formatjson("https://api.thingiverse.com/search/#{tag.tag}/?access_token=#{token}&page=#{page.to_s}")
        res.each do |project|
          if id.include? project["id"]
            puts "ALERT:: #{project["name"]} is already in the database"
          else
            project_detail = formatjson("#{project["url"]}?access_token=#{token}")
            api_file = formatjson("#{project_detail["files_url"]}?access_token=#{token}")
            if project_detail["default_image"] == nil
              puts "ALERT:: #{project["name"]}is empty"
            else #insert project
              url_image = []

              project_detail["default_image"]["sizes"].each do |image|
                url_image << image["url"]
              end
              Drone.create(title: project["name"], user: project["creator"]["name"], id: project["id"], tv_image: url_image)

              api_file.each do |file|
                
                url_image_file = []
                if file["name"].last(3).upcase != "STL"
                  url_image_file << "no image"
                else
                  #check if there are image into file
                  images = file["default_image"]
                  if images.nil?
                    puts "no image in to file"
                  else
                    file["default_image"]["sizes"].each do |image|
                      url_image_file << image["url"]
                    end
                  end
                end
                drone = Drone.find(project["id"])
                drone.file3ds.create(id: file["id"], name: file["name"], size: file["formatted_size"],  download: file["public_url"] , image: url_image_file)
              end
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
