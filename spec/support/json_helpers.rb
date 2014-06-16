module JsonHelpers
  def json
    @json ||= ActiveSupport::JSON.decode(response.body)
  end
end
