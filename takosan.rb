#!/usr/bin/env ruby
require 'net/http'
require 'uri'

takosan = ENV['takosan']
channel = ENV['channel']
job     = ENV['job']
url     = ENV['url']

puts "takosan: #{takosan}"
puts "channel: #{channel}"
puts "job: #{job}"
puts "url: #{url}"

http = Net::HTTP.new(URI(url).host, URI(url).port)
req = Net::HTTP::Get.new(URI(url).path + 'api/xml')
res = http.request(req)
xml = res.body

result = xml.match(/<result>(.+?)</)[1]
icon = case result
       when 'ABORTED'; ':warning:'
       when 'SUCCESS'; ':white_check_mark:'
       when 'FAILURE'; ':critical:'
       else          ; ':grey_question:'
       end

message = "#{icon} Jenkins (%s): %s - %s" % [job, result, url]
http = Net::HTTP.new(URI(takosan).host, URI(takosan).port)
req = Net::HTTP::Post.new(URI(takosan).path)
req.form_data = { 'channel' => channel, 'message' => message }
http.request(req)
