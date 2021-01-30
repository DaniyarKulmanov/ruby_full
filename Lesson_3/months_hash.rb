months = {
  Jan: 31, Feb: 28, March: 31, April: 30, May: 31, Jun: 30,
  Jule: 31, Aug: 31, Sep: 30, Okt: 31, Nov: 30, Dec: 31
}

months.each do |name, days|
  puts "#{name}" if days == 30
end