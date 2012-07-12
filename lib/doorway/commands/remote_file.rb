module RemoteFile
  def remote_file(remote, local)
    conn.scp.upload! local, remote
  end
end