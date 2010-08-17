require "#{File.dirname(__FILE__)}/../../vendor/plugins/moonshine/lib/moonshine.rb"

class ApplicationManifest < Moonshine::Manifest::Rails
  recipe :default_stack

  def application_packages
  end
  recipe :application_packages
end
