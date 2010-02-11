class CardPool

	DECK = [ :ace, 2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king ]
	
	def initialize(number_of_decks=2)
		@cards = DECK * number_of_decks
	end

	def hit_me
		(@cards.size * rand).to_i
	end

end

CardPool.new
exit

@cards = [ :ace, 2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king ]
@outcomes = Hash.new {|h, k| h[k] = 0 }

face_card = 7



@cards.each do |hole_card|
	total = 7

	puts "hole_card = #{hole_card}"

	while (total < 17) do

		case hole_card
			when :ace  : total += (total > 10) ? 1 : 11
			when 2..10 : total += hole_card
			when :jack, :queen, :king : total += 10
		end

		puts "hit, total = #{total}"
	end

	puts "\n\n"

	total = :bust if total > 21
	@outcomes[total] += 1
end

puts @outcomes.inspect
