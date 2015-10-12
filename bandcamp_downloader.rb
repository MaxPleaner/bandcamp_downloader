require 'byebug'
require 'mechanize'
require 'colored'

class BandcampDownloader
  LINKS_REGEX = /poppler[^\"\{\}]+/
  @@mechanize = Mechanize.new.tap do |agent|
    agent.keep_alive = false
    agent.idle_timeout = 300 # allow 5 minutes to download each track
  end

  def self.begin
    url         = ARGV.shift.gsub("https", "http"); require_url(url)
    puts "downloading index".green
    text        = `curl #{url}`
    links       = get_links(text)
    artist_name = url.scan(/http\:\/\/(.+)\.bandcamp\.com/).flatten.first

    puts "found #{links.length} link(s)".green
    links.each_with_index do |link, index|
      filename = "#{artist_name}-#{SecureRandom.uuid}.mp3"
      puts "downloading track #{index + 1}".green
      download_link(link, filename)
    end
    puts "done".green
  end
  def self.make_output_folder(output_folder)
    begin 
      `mkdir #{output_folder}`
    rescue
      puts "Error making folder #{output_folder}. Does it already exist?"
      exit
    end
  end
  def self.download_link(link, filename)
    @@mechanize.get(link).save_as(filename)
  end
  def self.get_links(text)
    links = text.scan(LINKS_REGEX)
    unless links
      puts "No track links were found. Make sure to enter the url" +
           "of the stream page, not the album selection page"
      exit
    end
    links.map { |link| URI.parse("http://" + link) }
  end
  def self.require_url(url)
    unless url
      puts "Must specify URL as first command line argument" +
           "i.e. 'ruby bandcamp_downloader.rb" +
           "http://fullemployment.bandcamp.com'"
      exit
    end
  end
end
if $0 == __FILE__
  BandcampDownloader.begin
end
