module AlbumsHelper
  def links_to_tracks(album)
    links_html = "<ul>"
    album.tracks.each do |track|
      links_html << "<li><a href=\"/tracks/#{track.id}\">#{track.name}</a></li>"
    end
    links_html << "</ul>"

    links_html.html_safe
  end
end
