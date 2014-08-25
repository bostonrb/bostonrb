require Rails.root.join('lib/boston_rb_calendar')

module ApplicationHelper
  def upcoming_presentations
    @grouped_presentations = Presentation.upcoming.group_by_date(:asc)

    if @grouped_presentations.present?
      render :partial => 'pages/upcoming'
    end
  end

  def next_event
    if @next_event = Rails.cache.read(:next_event)
      render :partial => 'pages/next_event'
    end
  end

  def link_to_unless_current_with_span(name, options = {}, html_options = {})
     link_to_unless_current(name, options, html_options) do
        content_tag(:span, name)
     end
  end

  def page_title
    if content_for?(:page_title)
      content_for(:page_title)
    else
      'Ruby and Ruby on Rails Meetings, Project Nights, and Community'
    end
  end
end
