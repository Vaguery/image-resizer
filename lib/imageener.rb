require 'mini_magick'

module Jekyll
  class TozierPicserizer < Generator
    def generate(site)

      src = site.config["picserizer"]["source"]
      source_dir = File.join(site.source,src)
      sizes = site.config["picserizer"]["sizes"]
      target_dir = File.join(site.source,site.config["picserizer"]["target"])

      our_pictures = Dir.glob("#{source_dir}/*.jpg")

      sizes.each do |size|
        full_path = "#{target_dir}/#{size}"
        if Dir.exist?(full_path)
        #   puts "I found #{full_path}!"
        else
          Dir.mkdir(full_path)
        end
      end

      our_pictures.each do |pic_name|
        sizes.each do |size|
          new_name = "#{target_dir}/#{size.to_s}/" + File.basename(pic_name)
          if File.exist?(new_name)
            # puts "There's already a #{new_name}!"
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
