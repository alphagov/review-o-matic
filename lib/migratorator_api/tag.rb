class MigratoratorApi
  class Tag
    def self.all(options = {})
      page = options[:page] || 1

      response = MigratoratorApi.client.get("/tags.json?page=#{page}")
      tags = JSON.parse(response.body)["tags"]
    end

    def self.all_by_group(group, options = {})
      page = options[:page] || 1

      response = MigratoratorApi.client.get("/tags.json?group=#{group}&page=#{page}")
      tags = JSON.parse(response.body)["tags"]
    end
  end
end