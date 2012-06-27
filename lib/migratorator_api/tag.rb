class MigratoratorApi
  class Tag
    def self.all(options = {})
      page = options[:page] || 1

      parse_tags_from_response MigratoratorApi.client.get("/tags.json?page=#{page}")
    end

    def self.all_by_group(group, options = {})
      page = options[:page] || 1

      parse_tags_from_response MigratoratorApi.client.get("/tags.json?group=#{group}&page=#{page}")
    end

    def self.parse_tags_from_response(response)
      tags = JSON.parse(response.body)["tags"] || []
      tags.map {|t| OpenStruct.new( t["tag"] ) }
    end
  end
end