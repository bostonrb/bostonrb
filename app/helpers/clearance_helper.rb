module ClearanceHelper
  def signed_out_links
    links = { "Sign up" => new_user_path, "Sign in" => new_session_path }
    authentication_links = links.collect do |key, value|
      link_to key, value
    end
    authentication_links.to_sentence :last_word_connector => ", or ",
                                     :two_words_connector => " or "
  end
end
