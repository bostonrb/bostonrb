module Feedzirra
  module FeedEntryUtilities 
    def checksum
      Digest::MD5.hexdigest("#{title}--#{url}--#{summary}--#{content}")
    end    

    def attributes
      { :title        => title,
        :url          => url,
        :author       => author,
        :summary      => summary,
        :content      => content,
        :published_at => published,
        :categories   => categories.join(', '),
        :checksum     => checksum}
    end
  end
end
