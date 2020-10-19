# For dealing with game IO

class CliIO
  def puts(msg)
    puts msg
  end
  def gets
    gets
  end
end

class NoOpIO
  def puts(msg)
    # noop
  end
  def gets(msg)
    # noop
  end
end
