module Doorway::Exec
  def exec(command)
    conn.exec! command
  end
end