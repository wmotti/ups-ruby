module UPS
  module Exceptions
    class InvalidUrlException < StandardError; end
    class InvalidAttributeError < StandardError; end
    class AuthenticationRequiredException < StandardError; end
    class UnavailableServiceException < StandardError; end
  end
end
