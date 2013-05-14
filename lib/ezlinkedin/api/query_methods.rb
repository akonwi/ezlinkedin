module EzLinkedin
	module Api

		module QueryMethods

			# The main option here is an array('fields') of desired profile fields to return
			def profile(options={})
				if fields = options.delete(:fields)
					get('/people/~:(#{fields.join(,)}))', options)
				else
					get('/people/~', options)
				end
			end

		end

	end
end
