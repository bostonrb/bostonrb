class PresentationPresenter < ActiveRecord::Base
  belongs_to :presentation
  belongs_to :presenter
end
