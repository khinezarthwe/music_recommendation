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
   # uniquesong =[]
    artist_name = 4
    song_name = 6
    unique_track_id = Allsong.select(:traid).distinct
    p unique_track_id.to_a

    #unique_track_id.each do |traid|
     # songdata = Allsong.find_by_traid(traid)
     # p songdata
      #uniquesong.push(traid,songdata[artist_name],songdata[song_name])
    #end
    #p uniquesong.count
    
    end
  end
