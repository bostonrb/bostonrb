class MoveNamesToPresenterModel < ActiveRecord::Migration
  def self.up
    Presentation.all.each do |presentation|
      presenter = Presenter.find_or_create_by_name(presentation.presenter_name)
      presentation.update_attribute(:presenter_id, presenter.id)
    end

    remove_column :presentations, :presenter_name
  end

  def self.down
    add_column :presentations, :presenter_name, :string

    Presenter.all.each do |presenter|
      presenter.presentations.each do |presentation|
        presentation.update_attribute(:presenter_name, :presenter.name)
      end
    end
  end
end
