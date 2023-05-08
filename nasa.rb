require 'json'
require 'uri'
require 'net/http'

def request(url)
  url=URI("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=4CRI39bN6hmOFwsxS2c6xiSOeNpNKqVG2FznEOf7")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  request = Net::HTTP::Get.new(url)
  response = http.request(request)
  if response.code == "200"
    return JSON.parse(response.body)
  else
    puts "Error"
  end
end

url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=4CRI39bN6hmOFwsxS2c6xiSOeNpNKqVG2FznEOf7"
response = request(url)
puts response

photos = []
response["photos"].each do |photo|
  photos << photo["img_src"]
end
puts photos

def build_web_page(data)
  html = "<html>\n<head>\n</head>\n<body>\n<ul>\n"
  data["photos"].each do |photo|
    html += "<li><img src='#{photo["img_src"]}'></li>\n"
  end
  html += "</ul>\n</body>\n</html>"
  return html
end

def photos_count(data)
  count = Hash.new(0)
  data["photos"].each do |photo|
    count[photo["camera"]["name"]] += 1
  end
  return count
end

url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=4CRI39bN6hmOFwsxS2c6xiSOeNpNKqVG2FznEOf7"
response = request(url)
puts response

photos = []
response["photos"].each do |photo|
  photos << photo["img_src"]
end
puts photos

html = build_web_page(response)
puts html

count = photos_count(response)
puts count