module Doorway::Packages
  def update_packages
    exec_as :root, "apt-get update"
  end

  def install(package)
    exec_as :root, 
      "DEBIAN_FRONTEND=noninteractive apt-get install -y -q #{package}"
  end

  def add_ppa(ppa)
    exec_as :root, "add-apt-repository ppa:#{ppa}"
    update_packages
  end
end