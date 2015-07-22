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
end
