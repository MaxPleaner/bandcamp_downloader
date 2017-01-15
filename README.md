### Bandcamp Downloader

This is a command line utility to download songs off of bandcamp.

It it written in Ruby, but is not gemmified.

**To use**:

Step 1. _move the executable to the PATH_:

```sh
  gem install mechanize colored
  git clone https://github.com/maxpleaner/bandcamp_downloader
  cd bandcamp_downloader
  chmod a+x bandcamp_downloader.rb
  sudo mv bandcamp_downloader.rb /usr/local/sbin
```

Step 2. _run script_

```sh
  bandcamp_downloader.rb <url>
```

This downloads the files to the current directory.
I didn't get around to naming the files according to the song names on the site,
but the metadata of the files is preserved and will show up in itunes/rhythmbox/etc.

You can also run `ruby_downloader.rb` with no arguments and be prompted for a url.

I have this aliased as `band <url`
