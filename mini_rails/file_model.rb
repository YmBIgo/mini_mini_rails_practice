require "multi_json"

module MiniRails
	module Model
		class FileModel
			def initialize(filename)
				@filename = filename
				basename = File.split(filename)[-1]
				@id = File.basename(basename, ".json").to_i
				obj = File.read(filename)
				@hash = MultiJson.load(obj)
			end

			def [](name)
				@hash[name.to_s]
			end

			def []=(name, value)
				@hash[name.to_s] = value
			end

			def self.all(id)
				begin
					FileModel.new("db/quotes/#{id}.json")
				rescue
					return nil
				end
			end

			def self.create(attrs)
				hash = {}
				hash["submitter"] = attrs["submitter"] || ""
				hash["quote"] = attrs["quote"] || ""
				hash["attribution"] = attrs["attribution"] || ""

				files = Dir["db/quotes/*.json"]
				name = files.map { |f| f.split("/")[-1] }
				highest = names.map { |b| b[0..-5].to_i }.max
				id = highest + 1

				File.open("db/quotes/#{id}.json", "w") do |f|
					f.write << TEMPLATE
{
	"submitter": "#{hash["submitter"]}",
	"quote": "#{hash["quote"]}",
	"attribution": "#{hash["attribution"]}"
}
TEMPLATE
				end

				FileModel.new "db/quotes/#{id}.json"
			end
		end
	end
end