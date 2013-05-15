module EzLinkedin

	module Request
		 DEFAULT_HEADERS = {
        'x-li-format' => 'json'
      }

      API_PATH = "https://api.linkedin.com/v1"

      protected

        def get(path, options={})
          response = access_token.get("#{API_PATH}#{path}", DEFAULT_HEADERS.merge(options))
          raise_errors(response)
          response.body
        end

			private

       	def raise_errors(response)
          # Even if the json answer contains the HTTP status code, LinkedIn also sets this code
          # in the HTTP answer (thankfully).
          case response.code.to_i
          when 401
            data = Mash.from_json(response.body)
            raise EzLinkedin::Errors::UnauthorizedError.new(data), "(#{data.status}): #{data.message}"
          when 400
            data = Mash.from_json(response.body)
            raise EzLinkedin::Errors::GeneralError.new(data), "(#{data.status}): #{data.message}"
          when 403
            data = Mash.from_json(response.body)
            raise EzLinkedin::Errors::AccessDeniedError.new(data), "(#{data.status}): #{data.message}"
          when 404
            raise EzLinkedin::Errors::NotFoundError, "(#{response.code}): #{response.message}"
          when 500
            raise EzLinkedin::Errors::InformLinkedInError, "LinkedIn had an internal error. Please let them know in the forum. (#{response.code}): #{response.message}"
          when 502..503
            raise EzLinkedin::Errors::UnavailableError, "(#{response.code}): #{response.message}"
          end
        end

	end

end
