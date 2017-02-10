require 'octokit'

module HandleOctokitArrayError
  def response_error_summary
    return nil unless data.is_a?(Hash) && !Array(data[:errors]).empty?

    summary = "\nError summary:\n"
    summary << data[:errors].map do |error|
      if error.is_a?(Hash)
        error.map { |k,v| "  #{k}: #{v}" }
      else
        "  #{error.inspect}"
      end
    end.join("\n")

    summary
  end
end

Octokit::Error.prepend(HandleOctokitArrayError)
