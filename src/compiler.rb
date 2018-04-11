#------------------
#|compiler.rb|
#|CompilerProgram|
#------------------
class Compiler
	def initialize(chm)
		@list_token={
			#Pleasewriteyournewmethodsettinghere.
			"print"=>1,
			"<br>"=>0,
			"="=>4,
			"++"=>5,
			"while"=>3,
			"whileend"=>nil
		}
		@list_type=[
			#Pleasewriteyournewtypesettinghere.
			[/".+"/,"STRING"],
			[/\w\!=\w/,"COND"]
		]
		@chomp=chm
		@token=[]
		@whilenum=[]
	end

	def run
		@i=0
		while true do
			case@chomp[@i]
			when"print"
				@i+=1
				@token.push("1#{@chomp[@i]}")
				@i+=1
			when"<br>"
				@i+=1
				#@token.push("0")
			when"while"
				@i+=1
				@whilenum.push(@token.size)
				@token.push("3#{@chomp[@i]}=")
				@i+=1
				if@chomp[@i]=="do"
					@i+=1
				end
			when"whileend"
				n=@whilenum[@whilenum.size-1]
				@token[n]="#{@token[n]}#{@token.size}"
				@whilenum.pop
				@i+=1
			when /(\w)\+\+/
				@token.push("5#{$1}")
				@i+=1
			when nil
				break
			else
				if@chomp[@i]=~/\w+/&&@chomp[@i+1]=="="
					@token.push("2#{@chomp[@i]}=#{@chomp[@i+2]}")
					@i+=3
				else
					error("NoMethodError")
				end
			end
		end
		return @token
	end

	deferror(msg)
	puts"Error:#{@i+1}thtoken(#{@chomp[@i]}):LexerError:#{msg}"
	exit
end
end
