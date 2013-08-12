module EzLinkedin
	module Search

		#
		# Search linkedin based on keywords or fields
		# @param  options [Hash or String] Hash of search criteria or
		#     a string of keyword(s).
		#     In order to specify fields for a resource(companies or people):
		#     pass in the fields as a hash of arrays with the type of search as the key.
    #     In this context, regular 'fields' key is for fields pertaining to the search
    #     and not the resource being searched on.
		#       client.search(:people => ['id', 'first-name'], fields: ['num-results'], first_name: 'bob')
		#       client.search(:company => ['id', 'name'], keywords: 'stuff')
		#
		# @return [Mash] hash of results
		def search(options)
      type = :people

      path = "/#{type.to_s}-search"
			if options.is_a?(Hash)
        if options.has_key? :company
          type = :company
			    path = "/#{type.to_s}-search"
        end
				if type_fields = options.delete(type.to_sym)
					if type != :people
						path += ":(companies:(#{type_fields.join(',')})#{search_fields(options)})"
					else
						path += ":(people:(#{type_fields.join(',')})#{search_fields(options)})"
					end
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
