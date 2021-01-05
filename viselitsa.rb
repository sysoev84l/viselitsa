#!/usr/bin/env ruby
# encoding: utf-8
#
# Популярная детская игра
# https://ru.wikipedia.org/wiki/Виселица_(игра)
#
# Этот код необходим только при использовании русских букв на Windows
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

# Подключаем библиотеку unicode_utils. Предварительно её надо установить, набрав
# в консоли:
#
# gem install unicode_utils
require "unicode_utils"

# В Windows загрузка этой библиотеки может внезапно занят продолжительное время
# (до минуты), если вы столкнулись с такой проблемой, подключите только
# необходимый модуль, написав:
#
#require "unicode_utils/upcase"

require_relative "game"
require_relative "result_printer"
require_relative "word_reader"

puts "Игра виселица. Версия 4. (c) goodprogrammer.ru\n\n"
sleep 1

printer = ResultPrinter.new

word_reader = WordReader.new

words_file_name = File.dirname(__FILE__) + "/data/words.txt"

# Все изменения логики будут у нас в классе Game. Нам нужно в двух местах
# преобразовать полученные данные в верхний регистр, используя метод upcase
# подключенного модуля UnicodeUtils: при генерации массива букв из полученного
# слова в конструкторе и при получении новой буквы от пользователя.
game = Game.new(word_reader.read_from_file(words_file_name))

while game.status == 0
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
