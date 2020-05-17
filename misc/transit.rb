require 'gtfs'
require 'net/http'

key = '11edabc0fb6d3a266874718dbfe1f1de'
feed_url = 'http://datamine.mta.info/mta_esi.php?key=11edabc0fb6d3a266874718dbfe1f1de&feed_id=1'
#url = URI.parse(feed_url)
#req = Net::HTTP::GET.new(feed_url.to_s)
#res = Net::HTTP.start(url.host, url.port) {|http|
#  http.request(req)
#}

source = GTFS::Source.build(feed_url)

puts(source.stop_times)

