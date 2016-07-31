require 'snake.rb'

Shoes.app do
	background "#AAA"
	#button "Start game!" do 
		s = Snake.new()
		para "The Snake is #{s.length} units long."
	#end
end