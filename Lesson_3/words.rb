words_hash = {}
word_number = 1
vowels = %w(a e i o u y)

'a'.upto'z' do |word|
  words_hash[word.to_sym] = word_number if vowels.include? word
  word_number +=1
end

puts words_hash