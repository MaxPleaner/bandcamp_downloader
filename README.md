### Bandcamp Downloader

Uses Curl and Ruby. This bypass the paywall ... and if it makes you feel bad, don't do it. 

To use the CLI script:

  - run the program with `ruby bandcamp_downloader.rb <url>`  
      - i.e. `ruby bandcamp_downloader.rb http://fullemployment.bandcamp.com` (one of my bands).
  - the files will be downloaded into whatever directory the scripwt was called from.  
      - i.e. if I call `ruby scripts/bandcamp_downloade.rb <url>` from `~/Downloads` then the files will be downloaded to `~/Downloads`. 
  - Unfortunately, the names of the tracks aren't included with the download. I might try and fix this. 
             

