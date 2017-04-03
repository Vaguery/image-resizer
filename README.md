# imageener

Made to automate making multiple images for a `srcset` in Jekyll. Does resizing only.

* Requires `mini_magick` (which itself requires `ImageMagick`)

## Using it

* Put `imageener.rb` in your `_plugins` folder
* In _config.yml add the following

~~~ yaml
picserizer:
  sizes: [300,600,900]   # width breakpoints for your images
  source: _source_images # path to the original images you want to convert
  target: images/posts   # location in your Jekyll project where you want the images to end up
  default_src: 300       # this is the size that will go in the `src` section for browsers that don't do `srcset`
~~~

Assuming you have your original wide images in `_source_images`, `imageener` will create directories `300`, `600`, and `900` in `images/posts` if they don't exist, and then will resize the original image to 300px, 600px, and 900px wide respectively. It will not delete the original images. If the folders and small images exist, it will not regenerate them.

You can then use the tags in an {% include-figure %} partial to suit.

### make `_your-partial.html`

For example, something like this:

~~~ html
{% assign td = site.picserizer.target %}
{% assign dd = site.picserizer.default_src %}
{% assign bf = include.base_image_filename %}

<figure>
<img
src="/{{ td }}/{{ dd }}/{{ bf }}"
sizes="(min-width: 800px) 50vw, 100vw"
srcset="{% for size in site.picserizer.sizes %}{% if forloop.last %}
/{{ td }}/{{ size }}/{{ bf }}  {{ size }}w{% else %}
/{{ td }}/{{ size }}/{{ bf }}  {{ size }}w, {% endif %}{% endfor %}"
alt="{{ include.alt }}"
title="{{ include.title }}">
<figcaption>{{ include.caption }}</figcaption>
</figure>
~~~

### call it in your post

`{% include _your-partial.html base_image_filename="filename.jpg"
title="title of picture" alt="description of picture"
caption="figure caption of picture" %}`
