module Exec
  def exec(command)
    conn.exec! command
  end
end