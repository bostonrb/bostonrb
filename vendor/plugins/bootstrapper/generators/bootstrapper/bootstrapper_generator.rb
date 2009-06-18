class BootstrapperGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory 'db'
      m.template 'bootstrap.erb', 'db/bootstrap.rb'
    end
  end
end