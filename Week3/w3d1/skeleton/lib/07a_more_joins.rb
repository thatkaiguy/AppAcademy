# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
  SELECT
    albums.artist
  FROM
    tracks
  INNER JOIN
    albums ON albums.asin = tracks.album
  WHERE
    tracks.song = 'Alison'
  SQL
end

def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
  SELECT
    albums.artist
  FROM
    tracks
  INNER JOIN
    albums ON albums.asin = tracks.album
  WHERE
    tracks.song = 'Exodus'
  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
  SELECT
    tracks.song
  FROM
    albums
  INNER JOIN
    tracks ON tracks.album = albums.asin
  WHERE
    albums.title = 'Blur'
  SQL
end

def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order first by
  # the number of such tracks, then by album title.
  execute(<<-SQL)
  SELECT
    albums.title, count(*) AS num_tracks
  FROM
    albums
  INNER JOIN
    tracks ON albums.asin = tracks.album
  WHERE
    tracks.song LIKE '%Heart%'
  GROUP BY
    albums.asin
  ORDER BY
    num_tracks DESC,
    albums.title
  SQL
end

def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  execute(<<-SQL)
  SELECT
    albums.title
  FROM
    albums
  INNER JOIN
    tracks ON tracks.album = albums.asin
  WHERE
    albums.title = tracks.song
  SQL
end

def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
  SELECT
    title
  FROM
    albums
  WHERE
    title = artist
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  execute(<<-SQL)
  SELECT
    tracks.song, count(*)
  FROM
    tracks
  INNER JOIN
    albums ON albums.asin = tracks.album
  GROUP BY
    tracks.song
  HAVING
    count(*) > 2
  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  execute(<<-SQL)
  SELECT
    albums.title, albums.price, count(*)
  FROM
    tracks
  INNER JOIN
    albums ON albums.asin = tracks.album
  GROUP BY
    albums.asin
  HAVING
    (albums.price / count(*)) < 0.50
  SQL
end

def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums in order of track count. Select both the
  # album title and the track count.
  execute(<<-SQL)
  SELECT
    albums.title,
    count(*) as track_ct
  FROM
    albums
  JOIN
    tracks ON albums.asin = tracks.album
  GROUP BY
    albums.asin
  ORDER BY
    track_ct DESC
  LIMIT 10

  SQL
end

def rock_superstars
  # Select the artist who has recorded the most rock albums, as well as the
  # number of albums. HINT: use LIKE '%Rock%' in your query.
  execute(<<-SQL)
  SELECT
    artist, count(*) AS artist_album_ct
  FROM
    albums
  JOIN
    styles
  ON styles.album = albums.asin
  WHERE
    style LIKE '%Rock'
  GROUP BY
    albums.artist
  ORDER BY
    artist_album_ct DESC
  LIMIT
    1
  SQL
end

def expensive_tastes
  # Select the five styles of music with the highest average price per track,
  # along with the price per track. One or more of each aggregate functions,
  # subqueries, and joins will be required.
  #
  # HINT: Start by getting the number of tracks per album. You can do this in a
  # subquery. Next, JOIN the styles table to this result and use aggregates to
  # determine the average price per track.

  execute(<<-SQL)
  SELECT
    styles.style,
    ( sum(COALESCE(albums.price, 0)) / sum(album_track_ct.ct) ) style_avg
  FROM
    styles
  JOIN
    (SELECT
      albums.asin as asin,
      count(*) as ct
    FROM
      albums
    JOIN
        tracks ON tracks.album = albums.asin
      GROUP BY
        albums.asin) as album_track_ct
      ON album_track_ct.asin = styles.album
  JOIN
    albums ON albums.asin = album_track_ct.asin
  GROUP BY
    styles.style
  ORDER BY
    style_avg DESC
  LIMIT 5
  SQL
end
