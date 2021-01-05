# encoding: utf-8
#
# Класс WordReader, отвечающий за чтение слова для игры.
class WordReader
  def read_from_args
    return ARGV[0]
  end

  def read_from_file(file_name)
    # Проверку наличия файла можно заменить на блок begin-rescue, при этом
    # ловить только конкретную ошибку обращения к файловой системе.
    #
    # https://ruby-doc.org/core-2.4.0/SystemCallError.html
    begin
      file = File.new(file_name, "r:UTF-8")
      lines = file.readlines
      file.close
    rescue SystemCallError
      # Если файл со словами не удалось открыть, нет смысла играть, поэтому тут
      # в пору закрыть программу и написать об этом пользователю
      abort "Файл со словами не найден!"

      # Важная оговорка: в профессиональной разработке классу не очень хорошо
      # доверять закрытие программы, класс должен «кинуть» ошибку, которую затем
      # нужно поймать в основной программе все тем же begin-rescue, но для
      # простоты мы сейчас поступим именно так.
      #
      # https://ruby-doc.org/core-2.4.0/Kernel.html#method-i-raise
    end

    return lines.sample.chomp
  end
end
