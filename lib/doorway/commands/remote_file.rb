module Doorway::RemoteFile
  def remote_file(remote, options)
    if options.is_a?(Hash)
      if template = options.delete(:template)
        local = temp_from_template(template, options)
      end
    else
      local = options
    end

    raise "You need to specify a local file or a template" unless local

    conn.scp.upload! local, remote
  end
end