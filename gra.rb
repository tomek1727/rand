
def newword()
  words = File.readlines("words.txt")
  word = words.sample
  if (5..12).include?(word.length)
     word.downcase.chomp.split("")
  else
    newword()
  end
end

def newpassword(word)
  password = []
  word.each  do |x|
    if rand(2) == 1
      password << "_"
    else
      password << x
    end
  end
  password
end

def zapisz(word, password, chars)
  f = File.open("save.txt", "a")
  f.seek(0, IO::SEEK_END)
  game = [password.join , word.join , chars.join].join(" ")
  f.puts "#{game}"
  f.close
end

def wczytaj()
  passwords = File.readlines("save.txt")
  puts "\n\n Wybierz grę do wczytania:"
  passwords.each_with_index do |x,i|
    puts "[#{i}]#{x.split[0]}"
  end
  puts "[#{passwords.length}]wróć do menu"
  pick = $stdin.gets.chomp.to_i
  if pick < passwords.length
    arr = passwords[pick].split
    gra(arr[1].chomp.split(""), arr[0].split(""), arr[2].split(""))
  end
end


def gra(word, password, chars)
  while true
    password.each {|x| print x}
    puts "\n\nUżyte litery: #{chars.join(",")} \n"
    print "Wybierz litere(Aby zapisać grę i wyjść[69]): "
    char = $stdin.gets.chomp.to_s
    if char == "69"
      zapisz(word, password, chars)
      break
    end
    (0...password.length).each {|x|password[x] = char if word[x] == char and password[x] == "_"}
    chars << char if chars.none? {|x| x == char}
    if password.none? {|x| x == "_"}
      puts "Wygranko!\tHasło to #{word.join.capitalize}"
      break
    end
  end
end

while true
  puts"[1] Nowa Gra"
  puts"[2] Wczytaj Grę"
  puts"[3] Koniec Gry"
  pick = $stdin.gets.chomp.to_s
  case pick
  when "1"
    word = newword()
    gra(word, newpassword(word), [])
  when "2"
    wczytaj()
  when "3"
    exit(0)
  end
end
