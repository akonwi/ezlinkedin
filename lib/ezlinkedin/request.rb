module EzLinkedin
	module Request
		 DEFAULT_HEADERS = {
        'x-li-format' => 'json'
      }

      API_PATH = '/v1'

      protected

        def get(path, options={})
          response = access_token.get("#{API_PATH}#{path}", DEFAULT_HEADERS.merge(options))
          raise_errors(response)
          response.body
        end
	end
end
