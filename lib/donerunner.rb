#!/usr/bin/env ruby

require 'json'
require 'date'

class DoneRunner

	class Done
		attr_accessor :text, :date
		def initialize(text, date = Date.today)
			@text = text
			@date = date
		end

		def to_json(options)
	        {'text' => @text, 'date' => @date}.to_json
	    end

	    def self.from_json data
	        self.new data['text'], data['date']
	    end
	end

	def self.sort_and_display(array)
		group = array.group_by { |s| s.date}

		group.each do |k,v|
			puts "Date: " + k
			v.each do |value|
				puts "- " + value.text
			end
		end
	end

	def self.execute (args)

		if File.file?("db")
			file = File.open("db", "rb")
			contents = file.read
			array ||= []

			JSON.parse(contents).each do |e|
				array.push Done.from_json e
			end
		end

		if args.length == 0
			sort_and_display array
		else

			text = args.join(" ")

			t = Done.new(args.join(" "))

			array.push t

			file = File.open("db", "w")
			file.write(JSON.generate array)
		end
	end
end