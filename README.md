### Bandcamp Downloader

Uses Curl and Ruby. This bypass the paywall ... and if it makes you feel bad, don't do it. 

Dependencies:
  - depends on `mechanize` and `colored`. Install them using `bundle`.
  - `pry` or `byebug` dependencies might be in the source code during development, but any references to them can be removed. They are just for 
    debugging. `byebug` require Ruby 2+.

To use the CLI script:
  - `require` the program (from irb or another file) to load the BandcampDownloader class without executing anything.
  - run the program with no arguments to be prompted for a url
  - run the program with a url argument to download mp3s from the url
      - i.e. `ruby bandcamp_downloader.rb http://fullemployment.bandcamp.com` (one of my bands).
  - the files will be downloaded into whatever directory the scripwt was called from.  
      - i.e. if I call `ruby scripts/bandcamp_downloade.rb <url>` from `~/Downloads` then the files will be downloaded to `~/Downloads`. 
  - Unfortunately, the names of the tracks aren't included with the download. I might try and fix this. 
             

