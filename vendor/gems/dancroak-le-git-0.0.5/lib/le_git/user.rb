module Github
  class User
    include HappyMapper

    element :score,     Float
    element :name,      String
    element :actions,   Integer
    element :language,  String
    element :followers, Integer
    element :username,  String
    element :type,      String
    element :fullname,  String
    element :repos,     Integer
    element :id,        String
    element :pushed,    DateTime
    element :created,   DateTime
    element :location,  String

    def self.find(username)
      xml = RestClient.get("http://github.com/api/v2/xml/user/search/#{username}")
      users = parse(xml)
      users.first
    end

    def repositories
      Github::Repository.user(name)
    end
  end
end
