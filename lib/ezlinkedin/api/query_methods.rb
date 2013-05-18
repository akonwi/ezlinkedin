module EzLinkedin
	module Api

		module QueryMethods

			
			# 
			# Retrieve a certain profile depending on the options passed in.
			# @param  options={} [Hash] can be an array of fields and an id,
			#                           and a url to a public profile. This 
			#                           can also contain request headers
			# 
			# @return [Mash] a Mash hash representing the found profile
			def profile(options={})
				path = people_path(options)
				make_query(path, options)
			end

			private

				def people_path(options)
					path = "/people/"
					if id = options.delete(:id)
						path += "id=#{id}"
					elsif url = options.delete(:url)
						path += "url=#{CGI.escape(url)}"
					else
						path += '~'
					end
				end

				def make_query(path, options)
					fields = options.delete(:fields) || EzLinkedin.default_profile_fields
					if fields
						path += ":(#{fields.join(',')})"
					end
					Mash.from_json(get(path, options))
				end
		end

	end
end
