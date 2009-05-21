module ApplicationHelper

  def sentence_of(things, opts = {})
    if opts[:connector] == :or
      things.to_sentence :last_word_connector => ", or ",
                         :two_words_connector => " or "
    else
      things.to_sentence
    end
  end

end
