class PresentationGroup < ActiveRecord::Base
  belongs_to :presentation
  belongs_to :presenter

  validates_presence_of :presentation_id, :presenter_id
  validates_numericality_of :presentation_id, :presenter_id
end
