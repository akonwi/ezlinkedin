module EzLinkedin
	module Api

		module QueryMethods

			# The main option here is an array('fields') of desired profile fields to return
			def profile(options={})
				fields = options.delete(:fields) || EzLinkedin.default_profile_fields
				if fields
					json_text = get("/people/~:(#{fields.join(',')})", options)
				else
					json_text = get('/people/~', options)
				end
				Mash.from_json(json_text)
			end

		end

	end
end
