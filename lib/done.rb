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

    def ==(other)
	 @text == other.text && date == other.date
	end

end