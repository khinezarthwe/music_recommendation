# importing songs data as an admin

namespace :songimport do
  desc "imports data from a raw data table"
  task :data => :environment do
    require 'csv'
    CSV.foreach('db/topic_10withlda.csv',headers: true) do |row|
      traid = row[0]
      topic_num = 1
      artist_name = "need"
      song_name = "need"
      lyric = "need"
      user_id = 1
      p traid
      Song.create(topic_num:1,
                  artist_name:artist_name,
                  song_name:song_name,
                  lyric:lyric,
                  user_id:1,
                  traid: traid)
    end
  end

  task :topic_num => :environment do
    require 'csv'

  end



  task :artist_name_and_song_name => :environment do
    require 'csv'
    alltrack = Song.all
    
    #alltrack.each do  |t_id|
      #if Allsong.traid == t_id 
      #    artist_name = Allsong.artist_name
      #    song_name = Allsong.song_name
      #    Song.update(artist_name: artist_name,
      #                song_name: song_name)
      #  end
      #end
    end
  end
