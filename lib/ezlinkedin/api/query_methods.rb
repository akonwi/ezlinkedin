module EzLinkedin
	module Api

		module QueryMethods

			
			# 
			# Retrieve a certain profile depending on the options passed in.
			# @param  options={} [Hash] can be an array of fields as strings and an id,
			# 	and a url to a public profile. This can also contain request 
			#   headers
			# 
			# @return [Mash] a Mash hash representing the found profile
			def profile(options={})
				path = person_path(options)
				make_query(path, options, true)
			end


			# 
			# Retrieve the authenticated user's connections
			# @param  options={} [Hash] pass in fields and/or a count
			# 
			# @return [Mash] Mash hash of connections
			def connections(options={})
				path = "#{person_path(options)}/connections"
				make_query(path, options, true)
			end

			# 
			# Retrieve the user's social feed
			# @param  options={} [Hash] visit Linkedin's api to
			# 	see possible options. it will default to an 
			#   aggregated feed unless :scope => 'self'. 
			#   :types => [:shar, :recu, :apps] 
			#   :count => 5  
			# 
			# @return [Mash] Mash hash of updates 
			def network_updates(options={})
				path = "#{person_path(options)}/network/updates"
				make_query(path, options, false)
			end

			private

				def person_path(options)
					path = "/people/"
					if id = options.delete(:id)
						path += "id=#{id}"
					elsif url = options.delete(:url)
						path += "url=#{CGI.escape(url)}"
					else
						path += '~'
					end
				end

				# 
				# create a valid path to make a restful request
				# @param  path [String] current path
				# @param  options [Hash] set of options
				# @param  use_fields |boolean| does request need fields?
				#
				# @return [Mash] hash object with results
				def make_query(path, options, use_fields)

					fields = options.delete(:fields) || EzLinkedin.default_profile_fields if use_fields
					if fields
						path += ":(#{fields.join(',')})"
					elsif path.end_with? "network/updates"
						path += network_options(options).to_s # if getting updates, add relevant options to the path
					elsif count = options.delete(:count)
						path += "?count=#{count}"
					end

					Mash.from_json(get(path, options))
				end

				# handle the options passed in pertaining to network updates
				def network_options(options)
					path = "?"
					options_path = nil

					if types = options.delete(:types)
						types = types.map { |type| "type=#{type.to_s.upcase}" }
						options_path = types.join('&')
					end

					if count = options.delete(:count)
						string = "count=#{count}"
						options_path = add_to_path(string, options_path)
					end

					if scope = options.delete(:scope)
						string = "scope=self"
						options_path = add_to_path(string, options_path)
					end

					if options_path.nil?
						""
					else
						"#{path}#{options_path}"
					end
				end

				# helper for previous method
				def add_to_path(option, options_path)
					if options_path.nil?
						options_path = option
					else
						options_path += "&#{option}"
					end
				end
		end

	end
end
