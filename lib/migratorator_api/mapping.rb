class MigratoratorApi
  class Mapping

    def self.find_by_old_url(old_url, options = {})
      parse_mapping_from_response MigratoratorApi.client.get("/mapping.json?old_url=#{old_url}")
    end

    def self.find_by_new_url(new_url, options = {})
      page = options[:page] || 1
      parse_multiple_mappings_from_response MigratoratorApi.client.get("/mappings.json?new_url=#{new_url}&page=#{page}")
    end

    def self.find_random_mapping(tags = '')
      parse_mapping_from_response MigratoratorApi.client.get("/mappings/random.json?tags=#{tags}")
    end

    def self.find_by_id(id)
      parse_mapping_from_response MigratoratorApi.client.get("/mappings/#{id}.json")
    end

    def self.all_by_tag(tags, options = {})
      page = options[:page] || 1
      parse_multiple_mappings_from_response MigratoratorApi.client.get("/mappings.json?tags=#{tags}&page=#{page}")
    end

    def self.find_by_ids(ids)
      JSON.parse(MigratoratorApi.client.get("/mappings/by_id_array.json?id_array=#{ids}").body) 
    end

    def self.count_all_mappings
      mappings = JSON.parse(MigratoratorApi.client.get("/mappings.json").body)
      mappings["pages"]["total_entries"]
    end

    def self.parse_multiple_mappings_from_response(response)
      return false if response.code != "200"
      (JSON.parse(response.body)["mappings"] || []).map {|m| format_mapping(m) }
    end

    def self.parse_mapping_from_response(response)
      return false if response.code != "200"
      format_mapping JSON.parse(response.body)
    end

    def self.format_mapping(hash)
      OpenStruct.new( hash["mapping"] )
    end
  end
end
