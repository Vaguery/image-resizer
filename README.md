# imageener

Made to automate making multiple images for a `srcset` in Jekyll. Does resizing only.

* Requires `mini_magick`
* Put `imageener.rb` in your `_plugins` folder
* In _config.yml add the following

~~~ yaml
picserizer:
  sizes: [300,600,900]
  source: _source_images
  target: images/posts
~~~

Assuming you have your original wide images in `_source_images`, `imageener` will create directories `300`, `600`, and `900` in `images/posts` if they don't exist, and then will resize the original image to 300px, 600px, and 900px wide respectively. It will not delete the original images. If the folders and small images exist, it will not regenerate them.
