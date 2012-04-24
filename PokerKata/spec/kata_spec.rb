require './kata.rb'

describe "poker" do
  describe "comparing hands" do
    it "3 beats 2" do 
      winning_hand([3], [2]).should == :left
    end

    it "5 loses to 8" do
      winning_hand([5], [8]).should == :right
    end

    it "6,9 beats 8,7" do
      winning_hand([6, 9], [8, 7]).should == :left
    end
  end

  describe "comparing hands" do
    [ 
      { :left_hand => [6, 6], :right_hand => [8, 9], :winner => :left },
      { :left_hand => [8, 9], :right_hand => [6, 6], :winner => :right },
    ].each do |kvp|
      it "a pair beats a high card" do
        winning_hand(kvp[:left_hand], kvp[:right_hand]).should == kvp[:winner]
      end
    end

    [ 
      { :left_hand => [8, 8], :right_hand => [6, 6], :winner => :left },
      { :left_hand => [6, 6], :right_hand => [8, 8], :winner => :right },
      { :left_hand => [7, 6, 6], :right_hand => [4, 8, 8], :winner => :right },
      { :left_hand => [9, 4, 4], :right_hand => [9, 3, 3], :winner => :left},
      { :left_hand => [4, 9, 4], :right_hand => [3, 9, 3], :winner => :left},
      { :left_hand => [4, 6, 8, 8], :right_hand => [4, 5, 9, 9], :winner => :right}
    ].each do |kvp|
      it "highest pair wins #{kvp[:left_hand]} #{kvp[:right_hand]}" do
        winning_hand(kvp[:left_hand], kvp[:right_hand]).should == kvp[:winner]
      end
    end

    it "three of a kind beats a pair" do
      winning_hand([4, 8, 8, 8], [4, 5, 9, 9]).should == :left
    end
  end 

  def winning_hand left, right
    left.sort!.reverse!
    right.sort!.reverse!  
    
    #drop in check like has_pair below
    return :left if has_three_of_a_kind?(left)
    return :right if has_three_of_a_kind?(right)
    
    if(has_pair?(left) && has_pair?(right))
      return determine_winner_based_on_pairs left, right
    end
    return :right if has_pair? right
    return :left if has_pair? left
    
    return determine_winner_based_on_high_card left, right
  end
  
  def has_three_of_a_kind? hand
  	isThree = false
  	hand.each_cons(3) { |cards| isThree = true if (cards[0] == cards[1] && cards[1] == cards[2]) }
  	return isThree
  end

  def has_pair? hand
    isPair = false
    hand.each_cons(2) { |pair| isPair = true if pair[0] == pair[1] }
    return isPair
  end

  def pair_in hand
    pairedNumber = 0
    hand.each_cons(2) { |pair| pairedNumber = pair[0] if pair[0] == pair[1] }
    return pairedNumber
  end

  def determine_winner_based_on_high_card left, right
    return :left if left[0] > right[0]
      return :right
  end
  
  def determine_winner_based_on_pairs left, right
  	return :left if pair_in(left) > pair_in(right)
  	return :right
	end
end
