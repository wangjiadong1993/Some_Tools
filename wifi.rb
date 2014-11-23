#this file is about Wifi AP detection
#WARNING:   this is for OSX !!! 
#WARNING:  before using it, you should have a symbol link from airport app to the .../bin dir
#for n times, the computer detects the strength of the several routers (of the same ssid, in the example, is NUS, customizable, can be nil) 
#n is customizable
#at the end, it shows the report about each AP of the same WIFI network
#from the result, we can notice that, once your computer is still, the strength is quite stable，just a little bit fluctuation
#this can be used for wifi positioning once you know the location of each AP
#
#
class Record
	def initialize(param)
		#puts "New Record"
		@records = []
		@mac = param
	end
	def add_record(param)
		@records.push param
	end
	def get_mac
		return @mac
	end
	def show
		return  {@mac => @records}
	end
	public :add_record
end

#variable definition
#used as ssid
name = "NUS" # can be nil
#the array of all the distinct APs
@record_array  = []

#methods
#this is used to check whether there is a record about a certain AP, if there is, return it, otherwise, build a new record
def check_repeat param
	output  = @record_array.each do |record|
		if record.get_mac == param
			break  record 
		end
	end
	if output.kind_of?(Array)
		output = Record.new(param)
		@record_array << output
	end
	output
end	
#to add a record, so need to call the check_repeat first
def add_record param, strength
	record = check_repeat(param)
	record.add_record(strength)
end

#main function part, iteration and call the system command
(0..20).each do |i|
	puts i
	output = `airport -s #{name}`
	output_array = output.split("\n")
	output_array.each do |info|
		if !info.scan(/[a-f0-9:]{17}\s\-\d+/).empty?#make sure it is not empty
			temp_str = info.scan(/[a-f0-9:]{17}\s\-\d+/).last  #extreme condition is the ssid is in this form
			mac_addr = temp_str.scan(/\S+/)[0]
			sig_stre = temp_str.scan(/\S+/)[1]
			#			puts token_array[1] + " " + token_array[2]
			add_record mac_addr, sig_stre
		end
	end

end


#show the report of all results
@record_array.each do |record|
	puts	record.show	
end
