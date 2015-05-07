namespace :suck_tv do
  desc "Suck project of Thinghiverse"
  task :suck => :environment do
    puts "What do you want to insert into db?"
    @ask = STDIN.gets.chomp.to_s
    if @ask.include? " "
      @ask = @ask.gsub!(' ', '%20')
    end

    @token = Token.all[0].content
    @page = 1
    @id_tv_db= []

    Drone.all.each do|project_db|
      @id_tv_db << project_db.tv_id.to_s
    end



    while Net::HTTP.get(URI("https://api.thingiverse.com/search/#{@ask}/?access_token=#{@token}&page=#{@page.to_s}")) != "{\"error\":\"Not Found\"}"

      uri = URI("https://api.thingiverse.com/search/#{@ask}/?access_token=#{@token}&page=#{@page.to_s}")
      body = Net::HTTP.get(uri)
      res = JSON.parse(body)
      res.each do |project|
        if @id_tv_db.include? project["id"]
          puts "ALLERT:: #{project["name"]}already in the database"
        else
          Drone.create(title: project["name"], tv_user: project["creator"]["name"], tv_id: project["id"])
          puts "OK:: #{project["name"]} insert"
        end
      end
    @page += 1
    puts "next #{@page}..."
    end
    puts "done trasfert"
  end


  desc "Delete Tolken"
  task :delete_tolken => :environment do
    Token.all.each do |token|
      token.destroy
    end
  end
end
