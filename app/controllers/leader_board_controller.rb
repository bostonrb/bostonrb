class LeaderBoardController < ApplicationController
  def index
    @grouped_presenters_by_score = Presenter.group_by_score
  end
end
