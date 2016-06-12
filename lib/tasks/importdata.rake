# importing all data for raw data.....

# Quotes a string, escaping any ' (single quote) and \ (backslash) characters.
def quote_string(s)
  s.to_s.gsub(/\\/, '\&\&').gsub(/'/, "''") # ' (for ruby-mode)
end

namespace :importdata do
  desc "imports data from a csv file"
  task :data => :environment do
    require 'csv'
    OriginalSong.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!("original_songs")
    inserts = []
    Allsong.select("distinct traid,artist_name,artist_id,trackname").order("traid").to_a.each do |song|
      artist_id     = song.artist_id
      artist_name   = song.artist_name
      traid         = song.traid
      track_name    = song.trackname
      created_at    = Time.now
      updated_at    = created_at
      inserts.push "('#{quote_string(traid)}', '#{quote_string(track_name)}', '#{quote_string(artist_id)}', '#{quote_string(artist_name)}', '#{created_at}', '#{updated_at}')"
    end

    sql = "INSERT INTO original_songs (traid, track_name, artist_id, artist_name, created_at, updated_at) VALUES #{inserts.join(", ")}"
    ActiveRecord::Base.connection.execute(sql)
  end


  task :original_songs_to_song_table => :environment do
    desc "original_songs_to_song_table"

    ActiveRecord::Base.transaction do
      Song.all.each do|s|
        song_update = OriginalSong.find_by_traid(s.traid)
        next if song_update.nil?
        s.artist_name = song_update.artist_name
        s.artist_id   = song_update.artist_id
        s.song_name   = song_update.track_name
        s.traid       = song_update.traid
        s.save!
      end
    end
  end

  task :adding_song_lyric => :environment do
    desc "Adding lyric to song database"

    Dir.foreach('db/lyricdata') do |filename|
      next if filename == '.' or filename == '..' or filename == '.DS_Store'
      file =  File.read('db/lyricdata/' + filename)
      lyricdata = Song.find_by_traid(filename.chomp('.txt'))
      lyricdata.lyric = file
      if lyricdata.lyric.to_s == ''
        lyricdata.lyric = "Sorry we can provide lyric for this song"
      end
      lyricdata.save!
    end

  end
  task :topic_num => :environment do
    desc "Selecting topic number"
    require 'csv'

    def find_smallest_column(values)
      values.each_with_index.max[1]
    end

    data = CSV.read("db/topic_10withlda.csv", headers: true, converters: :numeric)
    headers = data.headers
    data.each do|row|
      index = find_smallest_column(row.fields[1..-1])
      puts "Song ID: #{row[0]}"
      puts "Topic: #{index}"
    end

  end

end





