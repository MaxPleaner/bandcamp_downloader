require 'mechanize'
require 'colored'
require 'byebug'
class BandcampDownloader
  LINKS_REGEX = /poppler[^\"\{\}]+/
  @@mechanize = Mechanize.new.tap do |agent|
    agent.keep_alive = false
    agent.idle_timeout = 300 # allow 5 minutes to download each track
  end
  def self.get_url
    puts "enter url".green
    url = gets.chomp.gsub("https", "http")
  end
  def self.begin(url)
    puts "downloading index".green
    index_text = `curl #{url}`
    download_links({
      links: get_links(index_text),
      artist_name: url.scan(/http\:\/\/(.+)\.bandcamp\.com/).flatten.first
    })
    puts "done".green
  end
  def self.download_links(options)
    puts "found #{options[:links].length} link(s)".green
    options[:links].each_with_index do |link, index|
      filename = "#{options[:artist_name]}-#{SecureRandom.uuid}.mp3"
      puts "downloading track #{index + 1}".green
      download_link(link, filename)
    end
  end
  def self.make_output_folder(output_folder)
    begin 
      `mkdir #{output_folder}`
    rescue
      puts "Error making folder #{output_folder}. Does it already exist?".red
      exit
    end
  end
  def self.download_link(link, filename)
    @@mechanize.get(link).save_as(filename)
  end
  def self.get_links(text)
    byebug
    links = text.scan(LINKS_REGEX)
    unless links
      puts "No track links were found. Make sure to enter the url ".red +
           "of the stream page, not the album selection page".red
      exit
    end
    links.map { |link| URI.parse("http://" + link) }
  end
end

if $0 == __FILE__
  if (url = ARGV.shift)
    BandcampDownloader.begin(url)
  else
    BandcampDownloader.begin(BandcampDownloader.get_url)
  end
end
