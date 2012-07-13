module Doorway::Get
  def get(file, path, save_as=nil)
    extra = save_as ? "-O #{save_as} " : ""
    wget = "wget -q #{extra}#{file}"
    exec "cd #{path} && #{wget}"
  end
end