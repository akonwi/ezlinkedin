module EzLinkedin
	module Search

		#
		# Search linkedin based on keywords or fields
		# @param  options [Hash or String] Hash of search criteria or
		#     a string of keyword(s).
		#     In order to specify fields for a resource(companies or people):
		#     pass in the fields as a hash of hashes.
		#       client.search(:people => ['id', 'first-name'], fields: ['num-results'])
		#       client.search(:companies => ['id', 'name'])
		# @param  type="people" [String or symbol] :people or :company search?
		#
		# @return [Mash] hash of results
		def search(options, type="people")
			path = "/#{type.to_s}-search"

			if options.is_a?(Hash)
				if type_fields = options.delete(type.to_sym)
					path += ":(#{type.to_s}:(#{type_fields.join(',')})#{search_fields(options)})"
				end
				path += configure_fields(options)
			elsif options.is_a?(String)
				path += configure_fields({keywords: options})
				options = {}
			end

			Mash.from_json(get(path, options))
		end

		private

			def search_fields(options)
				if fields = options.delete(:fields)
					",#{fields.join(',')}"
				end
			end

			def configure_fields(options)
				path = ""
				options.each do |k, v|
					key = format_for_query(k.to_s)
					path += "#{key}=#{URI::encode(v)}"
					options.delete(k)
				end
				path = "?#{path}" unless path.empty?
				path
			end

			def format_for_query(key)
				key.gsub("_", "-")
			end
	end
end