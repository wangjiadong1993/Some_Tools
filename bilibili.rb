require 'net/http'
require 'json'
require 'mechanize'
puts "please input the url"
url = nil
url =gets.chomp
url = URI(url)
#x = Net::HTTP.get(url)
agent = Mechanize.new
agent = agent.get(url)
if agent.nil?
	puts "network error or wrong url"
	return 0;
end
#x = x.scan(/flashvars=[^\s]+/)[0]
agent = agent.parser.at('.player-wrapper').content
if agent.nil?
	puts 'wrong website resource'
	return 0;
end
agent = agent.scan(/\d+/)[0]
if agent.nil?
	puts 'wrong website resource'
	return 0;
end
# puts x
# url = URI.parse()
system("open", "http://comment.bilibili.com/"+agent.to_s+".xml")
# file = File.open("/Users/wangjiadong/Desktop/"+"2083276.xml", 'w')
# file.write(url)
# puts Net::HTTP.get(url)
