module Github
  class Commit
    include HappyMapper

    element :message, String
    element :url,     String
    element :id,      String
    element :tree,    String

    def self.master(repo_owner, repo_name)
      xml = RestClient.get("http://github.com/api/v2/xml/commits/list/#{repo_owner}/#{repo_name}/master")
      parse(xml)
    end
  end
end
