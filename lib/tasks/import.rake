# importing all data for raw data.....

namespace :import do
  desc "imports data from a csv file"
  task :data => :environment do
    require 'csv'
    CSV.foreach('db/allrawdata.csv') do |row|
      lastfm_userid 	= row[0]
      timestamp	  	= row[1]
      artist_id 		= row[2]
      artist_name		= row[3]
      traid			= row[4]
      trackname		= row[5]
      Allsong.create(lastfm_userid: lastfm_userid,
                     timestamp:timestamp,
                     artist_id: artist_id,
                     artist_name: artist_name,
                     traid: traid,
                     trackname: trackname)
    end
  end

  task :fastdata => :environment do
    CONN = ActiveRecord::Base.connection
    TIMES = 539466
    data_arr =[]
    require 'csv'
    CSV.foreach('db/allrawdata.csv') do |row|
      lastfm_userid   = row[0]
      timestamp     = row[1]
      artist_id     = row[2]
      artist_name   = row[3]
      traid     = row[4]
      trackname   = row[5]
      data_arr.push(lastfm_userid,timestamp,artist_id,artist_name,traid,trackname)
    end
    TIMES.times {CONN.exeute "INSERT INTO Allsong"}
  end
end
