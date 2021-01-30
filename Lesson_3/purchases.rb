def input (text)
  puts text
  gets.chomp
end

basket = {}
total_cost = 0

loop do
  product = input 'Введите название товара, введите Стоп для завершения'
  break if product.downcase == 'стоп'
  cost = input 'Введите цену за единицу товара'
  amount = input 'Сколько хотите купить?'
  basket[product.to_sym] = { cost: cost.to_f, amount: amount.to_f }
end

basket.each do |product, details|
  puts "Товар #{product}, цена #{details[:cost]}, #{details[:amount]} шт."
  total_product_cost =  (details[:cost] * details[:amount]).round(2)
  puts "Всего за #{product} = #{total_product_cost}"
  total_cost += total_product_cost
end

puts "Всего сумма покупок = #{total_cost.round(2)}"