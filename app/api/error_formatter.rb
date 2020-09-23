class ErrorFormatter
  def self.call message, backtrace, options, env, args
    { response_type: "error", response: message }.to_json
  end
end
