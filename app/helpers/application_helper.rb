module ApplicationHelper

  def sentence_of(things, opts = {}, &block)
    if block
      things = things.collect do |thing|
        capture(thing, &block)
      end
    end

    if opts[:connector] == :or
      things.to_sentence :last_word_connector => ", or ",
                         :two_words_connector => " or "
    else
      things.to_sentence
    end
  end

end
