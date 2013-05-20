module EzLinkedin
	module Api

		module UpdateMethods
			
			# 
			# post a share to Linkedin
			# @param  share [Hash] a hash containing at least the required
			#   attributes for a share. 
			#   post_share({:comment => "I'm a comment",
			#               :content => { :title => "A title!",
			#                             :description => "A description",
			#                             :submitted_url => "http...",
			#                             :submitted_image_url => "http..."
			#                             }
			#               :visibility => { :code => "anyone"}
			#               })
			# 
			# @return [HTTP::Response?] response of post call
			def post_share(share)
				path = "/people/~/shares"
				defaults = { visibility: { code: 'anyone' } }
				post(path, defaults.merge(share).to_json, "Content-Type" => "application/json")
			end
		end
	end
end
