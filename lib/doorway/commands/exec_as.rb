module ExecAs
  def exec_as(user, command)
    exec %Q[sudo -i -u #{user} bash -c "#{escape_chars(command)}"]
  end

  def escape_chars(command)
    command.gsub('"', '\"').gsub('$', '\$')
  end
end