module ApplicationHelper

  # name: lx
  # description: returns a navigation button for use in the dash
  # usage: lx(image to use, path to link to, text to display)
  def lx(image, path, text)
    link_to(content_tag(:div,image_tag("theme/default/"+image,
                                       :alt => t(text),
                                       :title => t(text)) + tag(:br) + t(text),
                        :class => 'menu_button'),path)
  end

  # name: ptext
  # description: returns text in a p tag, used for paragraphs and normal text
  # usage: ptext('tag_from_yml')
  def ptext(text)
    tag(:br) + content_tag(:p, t(text)) + tag(:br)
  end



  def p(text)
    (tag(:br) + content_tag(:p, t(text)) + tag(:br)).html_safe
  end

  # name: qtext
  # description: returns text in a qtext tag, used for quoted text
  # usage: qtext('tag_from_yml')
  def qtext(text)
    tag(:br) + content_tag(:qtext, t(text)) + tag(:br)
  end

  # name: ttext
  # description: returns text in a ttext tag, used for title text
  # usage: ttext('tag_from_yml')
  def ttext(text)
    tag(:br) + content_tag(:ttext, t(text)) + tag(:br)
  end

  # name: itext
  # description: returns text in a itext tag, used under images
  # usage: itext('tag_from_yml')
  def itext(text)
    tag(:br) + content_tag(:itext, t(text)) + tag(:br)
  end

  # name: xtext
  # description: returns text in a xtext tag, used for large text
  # usage: xtext('tag_from_yml')
  def xtext(text)
    tag(:br) + content_tag(:xtext, t(text)) + tag(:br)
  end

  # name: brn
  # description: returns a number of line break tags
  # usage: brn(number of line breaks)
  def brn(number)
    var = ""
    number.times do
      var += tag(:br)
    end
    var.html_safe
  end

  # name: br
  # description: returns a line break tag
  # usage: br()
  def br()
    tag(:br)
  end

  # name: gallery
  # description: returns a gallery of images in group
  # usage: gallery(string_list, gallery_name, alt_text)
  # string_list : list of pictures in the format of 'nn1.jpeg nnn.jpeg'
  # gallery_name: gallery id for grouping, example g1
  # alt_text: optional comma seperated alternative in the format of
  # 'text, text1, textn' to skip and entry leave as empty or a blank space
  # as follows 'text1, ,text3,,text5' if there are more images than entries
  # they will be left blank
  def gallery(string_list, gallery_name, alt_text = "")
    gallery_return = ""
    photos = string_list.split(/\ +/)
    photos_text = alt_text.split(',')
    photos.each_with_index{ |photo, index|
      gallery_return += link_to(image_tag("thumb/todd_ramirez_" + photo,
                                          :alt => photos_text[index],
                                          :title => photos_text[index]),
                                "assets/image/todd_ramirez_" + photo,
                                {:class => "image",
                                 "data-fancybox-group" => gallery_name})
      gallery_return += "&nbsp;"
    }
    gallery_return.html_safe
  end

  # name: photo
  # description: returns a photo
  # usage: photo(image, alt_text)
  # image: image in the format of 'nnn.jpeg'
  # alt_text: optional alternate text in the format of 'some text'
  def photo(image, alt_text = "")
    image_tag("image/todd_ramirez_" + image,
              :alt =>  alt_text,
              :title => alt_text)
  end

  # name: photo_text
  # description: returns a photo with image text
  # usage: photo_text(image, text, alt_text)
  # image: image in the format of 'nnn.jpeg'
  # text: text to display under image use the yml tag 'tag_name'
  # alt_text: optional alternate text in the format of 'some text'
  def photo_text(image, text, alt_text = t(text))
    image_tag("image/todd_ramirez_" + image,
              :alt =>  alt_text,
              :title => alt_text) + tag(:br) +
      content_tag(:itext, t(text)) + tag(:br)
  end

  # name: photo_text_s
  # description: returns a photo with image text and 4 line breaks
  # usage: photo_text_s(image, text, alt_text)
  # image: image in the format of 'nnn.jpeg'
  # text: text to display under image use the yml tag 'tag_name'
  # alt_text: optional alternate text in the format of 'some text'
  def photo_text_s(image, text, alt_text = t(text))
    image_tag("image/todd_ramirez_" + image,
              :alt =>  alt_text,
              :title => alt_text) + tag(:br) +
      content_tag(:itext, t(text)) + tag(:br) + tag(:br) + tag(:br) + tag(:br)
  end

  # name lightbox_text
  # description: returns a photo in a lightbox, with image text
  # usage: lightbox_text(photo, gallery_name, text, alt_text)
  # photo: image in the format of 'nnn.jpeg'
  # gallery_name: gallery id for grouping, example g1
  # text: text to display under lightbox, use the yml tag 'tag_name'
  # alt_text: optional alternate text in the format of 'some text'
  def lightbox_text(photo, gallery_name, text, alt_text = t(text))
    link_to(image_tag("thumb/todd_ramirez_" + photo,
                      :alt => alt_text, :title => alt_text),
            "assets/image/todd_ramirez_" + photo,
            {:class => "image",  "data-fancybox-group" => gallery_name}) +
      tag(:br) + content_tag(:itext, t(text)) + tag(:br)
  end

  # name lightbox_qtext
  # description: returns a photo in a lightbox, with quoted image text
  # usage: lightbox_qtext(photo, gallery_name, text, alt_text)
  # photo: image in the format of 'nnn.jpeg'
  # gallery_name: gallery id for grouping, example g1
  # text: text to display under lightbox, use the yml tag 'tag_name'
  # alt_text: optional alternate text in the format of 'some text'
  def lightbox_qtext(photo, gallery_name, text, alt_text = t(text))
    link_to(image_tag("thumb/todd_ramirez_" + photo,
                      :alt => alt_text, :title => alt_text),
            "assets/image/todd_ramirez_" + photo,
            {:class => "image",  "data-fancybox-group" => gallery_name}) +
      tag(:br) + content_tag(:qtext, t(text)) + tag(:br)
  end

  # name lightbox
  # description: returns a photo in a lightbox
  # usage: lightbox(photo, gallery_name, alt_text)
  # photo: image in the format of 'nnn.jpeg'
  # gallery_name: gallery id for grouping, example g1
  # alt_text: optional alternate text in the format of 'some text'
  def lightbox(photo, gallery_name, alt_text = "")
    link_to(image_tag("thumb/todd_ramirez_" + photo,
                      :alt => alt_text, :title => alt_text),
            "assets/image/todd_ramirez_" + photo,
            {:class => "image",  "data-fancybox-group" => gallery_name}) +
      tag(:br)
  end

  # name: gallery_text
  # description: returns a gallery of images in group with image text below it
  # usage: gallery_text(string_list, gallery_name, text, alt_text)
  # string_list : list of pictures in the format of 'nn1.jpeg nnn.jpeg'
  # gallery_name: gallery id for grouping, example g1
  # text: text to display under gallery, use the yml tag 'tag_name'
  # alt_text: optional comma seperated alternative in the format of
  # 'text, text1, textn' to skip and entry leave as empty or a blank space
  # as follows 'text1, ,text3,,text5' if there are more images than entries
  # they will be left blank
  def gallery_text(string_list, gallery_name, text, alt_text = "")
    gallery_return = ""
    photos = string_list.split(/\ +/)
    photos_text = alt_text.split(',')
    photos.each_with_index{ |photo, index|
      gallery_return += link_to(image_tag("thumb/todd_ramirez_" + photo,
                                          :alt => photos_text[index],
                                          :title => photos_text[index] ),
                                "assets/image/todd_ramirez_" + photo,
                                {:class => "image",
                                 "data-fancybox-group" => gallery_name})
      gallery_return += "&nbsp;"
    }
    gallery_return += tag(:br) + content_tag(:itext, t(text)) + tag(:br)
    gallery_return.html_safe
  end


end
