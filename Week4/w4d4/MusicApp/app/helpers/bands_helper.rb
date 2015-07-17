module BandsHelper

  # def bands_list_links(bands)
  #   band_links = ""
  #   bands.each do |band|
  #     band_links << "<li><a href=\"/bands/#{band.id)}\"</a></li>"
  #   end
  #
  #   result = <<-HTML
  #     <ul>
  #       #{band_links}
  #     </ul>
  #   HTML
  #
  #   result.html_safe
  # end

  def links_to_albums(band)
    links_html = "<ul>"
    band.albums.each do |album|
      links_html << "<li><a href=\"/albums/#{album.id}\">#{album.title}</a></li>"
    end
    links_html << "</ul>"

    links_html.html_safe
  end
end
