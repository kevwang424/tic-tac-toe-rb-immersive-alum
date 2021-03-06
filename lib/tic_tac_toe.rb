
require "pry"

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    current_player = current_player(board)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.select {|element| !element.strip.empty?}.count
end

def current_player(board)
  if turn_count(board)%2 == 0
    return "X"
  else
    return "O"
  end
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)

  WIN_COMBINATIONS.each do |combo|
    return combo if combo.all? {|index| board[index] == "X"}
    return combo if combo.all? {|index| board[index] == "O"}
  end

  return false if board.all? {|box| box.strip.empty?}
  return false
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  end
end

def over?(board)
  if !won?(board) && full?(board)
    return true
  elsif full?(board) && won?(board)
    return true
  elsif won?(board)
    return true
  end
  return false
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
