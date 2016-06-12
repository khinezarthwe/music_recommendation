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
    desc "Selecting topic number"
    require 'csv'
    hasharr = {}
    data = CSV.read("db/topic_10withlda.csv", headers: true, converters: :numeric)
    headers = data.headers 
    data.each do|row|
      
      hash_arr = row.to_h
      songid = hash_arr["Song ID"]
      hash_arr.delete("Song ID")
      index = hash_arr.key(hash_arr.values.max)
      topic_number = Song.find_by_traid(songid)
      topic_number.topic_num = index
      topic_number.save!
    end

  end

end
