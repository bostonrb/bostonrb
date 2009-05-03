# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def tab_link_attributes(name)
    attributes = {}
    attributes[:class] = 'current' if controller.controller_name == name
    attributes
  end

  def anticaptcha
    content_tag(:div, :class => 'captcha') do
      label_tag(:captcha, 'Answer this if you are a roboto') + text_field_tag(:captcha)
    end
  end

  def sentence_of(things, opts = {})
    if opts[:connector] == :or
      things.to_sentence :last_word_connector => ", or ",
                         :two_words_connector => " or "
    else
      things.to_sentence
    end
  end

end
