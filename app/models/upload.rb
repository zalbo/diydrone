class Upload < ActiveRecord::Base
  belongs_to :drone

  has_attached_file :uploaded_file,
                    styles: lambda { |a| a.instance.check_file_type}

    def check_file_type
      if is_image_type?
        {:small => "x200>", :medium => "x300>", :thumb => "x100>" }
      else
        {}
      end
    end
      def is_image_type?
        uploaded_file_content_type =~ %r(image)
      end

    validates_attachment_content_type :uploaded_file, :content_type => [/\Aimage\/.*\Z/, /\Atext\/.*\Z/, /\Aapplication\/.*\Z/]

    def is_stl?
      uploaded_file_content_type =~ %r(text) || %r(application)
    end

    def generate_render_stl
      file = self.uploaded_file_file_name
      povfile = file.sub '.stl' , '.pov'
      pngfile = file.sub '.stl' , '.png'
      url = "#{Rails.root.to_s}/tmp"
      system("cp #{self.uploaded_file.path} #{url}")
      system("/usr/local/bin/stl2pov-master/stl2pov #{url}/#{file} >  #{url}/#{povfile}")
      system("povray +I#{url}/#{povfile} +O#{url}/#{pngfile} +D +P +W640 +H480 +A0.5")
      drone = Drone.find(self.drone_id)
      drone.uploads << Upload.new(uploaded_file: File.open("#{url}/#{pngfile}", 'rb'))
    end
end
