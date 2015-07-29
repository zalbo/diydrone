class RenderstlJob
  include SuckerPunch::Job

  def perform(event)


      file = event.uploaded_file_file_name
      povfile = file.sub '.stl' , '.pov'
      pngfile = file.sub '.stl' , '.png'
      url = "#{Rails.root.to_s}/tmp"
      system("cp #{event.uploaded_file.path} #{url}")
      system("/usr/local/bin/stl2pov-master/stl2pov #{url}/#{file} >  #{url}/#{povfile}")
      system("povray +I#{url}/#{povfile} +O#{url}/#{pngfile} +D +P +W640 +H480 +A0.5")
      drone = Drone.find(event.drone_id)
      drone.uploads << Upload.new(uploaded_file: File.open("#{url}/#{pngfile}", 'rb'))
      array_image = []
      drone.uploads.each do |image|
        if image.uploaded_file_content_type.start_with?("image")
          array_image << image.uploaded_file.url(:thumb)
        end
      end
      drone.update(image: array_image)
  end
end
