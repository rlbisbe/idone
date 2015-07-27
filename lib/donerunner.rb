#!/usr/bin/env ruby

require 'json'
require 'date'
require 'done'

class DoneRunner

	def self.group_and_sort(array, limit = nil)
		group = array.sort { |a,b| a.date <=> b.date}.reverse.group_by { |s| s.date}


		return limit.nil? ? group : Hash[group.take limit]
	end

	def self.sort_and_display(array, days = nil)
		group = group_and_sort(array, days)


		group.each do |k,v|
			puts "Date: " + k.to_s
			v.each do |value|
				puts "- " + value.text
			end
		end
	end

	def self.execute (args)
		array ||= []
		
		if File.file?("db")
			file = File.open("db", "rb")
			contents = file.read
			JSON.parse(contents).each do |e|
				array.push Done.from_json e
			end
		end

		if args.length == 0
			sort_and_display array
		elsif args[0] == "today"
			sort_and_display(array, 1)
		else
			text = args.join(" ")

			t = Done.new(args.join(" "))

			array.push t

			file = File.open("db", "w")
			file.write(JSON.generate array)
		end
	end
end
