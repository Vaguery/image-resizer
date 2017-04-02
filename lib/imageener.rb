require 'mini_magick'

module TozierImagePreprocessor
  class Generator < Jekyll::Generator
    def generate(site)

      source_dir = "pix"
      sizes = [300,600,900]
      target_dir = "images/posts"

      our_pictures = Dir.glob("#{source_dir}/*.jpg")

      sizes.each do |size|
        full_path = "#{target_dir}/#{size}"
        if Dir.exist?(full_path)
          puts "I found #{full_path}!"
        else
          Dir.mkdir(full_path)
        end
      end

      our_pictures.each do |pic_name|
        sizes.each do |size|
          new_name = "#{target_dir}/#{size.to_s}/" + File.basename(pic_name)
          if File.exist?(new_name)
            puts "There's already a #{new_name}!"
          else
            loaded_pic = MiniMagick::Image.open(pic_name)
            loaded_pic.resize size.to_s
            loaded_pic.format "jpg"
            loaded_pic.write(new_name)
          end
        end
      end
    end
  end
end
