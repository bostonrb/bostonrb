class CreatePresentationGroupsData < ActiveRecord::Migration
  def up
    Presentation.all.each do |presentation|
      presenter = presentation.presenter

      if presenter.name.match(/(&|,)/)
        presenter.name.split(/,|&/ix).each do |presenter_name|
          pres = Presenter.find_or_initialize_by_name(presenter_name.strip)
          presentation.presenters << pres
        end
      else
        presentation.presenters << presenter
      end    
    end
  end

  def down
  end
end
