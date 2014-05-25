module ApplicationHelper

def lx(image, path, text)
  link_to(content_tag(:div,image_tag("theme/default/"+image) + tag(:br) + t(text) ,:class => 'menu_button'),path)
end

def ptext(text)
  tag(:br) + content_tag(:ptext, t(text)) + tag(:br)
end

def qtext(text)
  tag(:br) + content_tag(:qtext, t(text)) + tag(:br)
end

def ttext(text)
  tag(:br) + content_tag(:ttext, t(text)) + tag(:br)
end

def itext(text)
  tag(:br) + content_tag(:itext, t(text)) + tag(:br)
end

def xtext(text)
  tag(:br) + content_tag(:xtext, t(text)) + tag(:br)
end
def brn(number)
  var = ""
number.times do
    var += tag(:br)
  end
  var.html_safe
end

def br()
  tag(:br)
end

def gallery(string_list, gallery_name)
  gallery_return = ""
  photos = string_list.split(/\ +/)
  photos.each{ |photo|
    gallery_return += link_to(image_tag("thumb/todd_ramirez_" + photo),"assets/image/todd_ramirez_" + photo,
                              {:class => "image",  "data-fancybox-group" => gallery_name})
    gallery_return += "&nbsp;"
  }
  gallery_return.html_safe
end

def photo(image)
  image_tag("image/todd_ramirez_" + image)
end

def photo_text(image, text)
  image_tag("image/todd_ramirez_" + image) + tag(:br) + content_tag(:itext, t(text)) + tag(:br)
end

def photo_text_s(image, text)
  image_tag("image/todd_ramirez_" + image) + tag(:br) + content_tag(:itext, t(text)) + tag(:br) + tag(:br) + tag(:br) + tag(:br)
end

def lightbox_text(photo, gallery_name, text)
  link_to(image_tag("thumb/todd_ramirez_" + photo),"assets/image/todd_ramirez_" + photo,
          {:class => "image",  "data-fancybox-group" => gallery_name}) + tag(:br) + content_tag(:itext, t(text)) + tag(:br)
end

def lightbox_qtext(photo, gallery_name, text)
  link_to(image_tag("thumb/todd_ramirez_" + photo),"assets/image/todd_ramirez_" + photo,
          {:class => "image",  "data-fancybox-group" => gallery_name}) +  tag(:br) + content_tag(:qtext, t(text)) + tag(:br)
end

def lightbox(photo, gallery_name)
  link_to(image_tag("thumb/todd_ramirez_" + photo),"assets/image/todd_ramirez_" + photo,
          {:class => "image",  "data-fancybox-group" => gallery_name}) + tag(:br)
end


def gallery_text(string_list, gallery_name, text)
  gallery_return = ""
  photos = string_list.split(/\ +/)
  photos.each{ |photo|
    gallery_return += link_to(image_tag("thumb/todd_ramirez_" + photo),"assets/image/todd_ramirez_" + photo,
                              {:class => "image",  "data-fancybox-group" => gallery_name})
    gallery_return += "&nbsp;"
  }
  gallery_return += tag(:br) + content_tag(:itext, t(text)) + tag(:br)
  gallery_return.html_safe
end


end
