module Crashplan
  class Error < StandardError; end
  class Error::AuthenticationError < Error; end
  class Error::UsernameNotEmail < Error; end
  class Error::EmailInvalid < Error; end
  class Error::InvalidUsername < Error; end
  class Error::OrgNameMissing < Error; end
  class Error::DuplicateOrg < Error; end
  class Error::ParentOrgBlocked < Error; end
  class Error::ParentOrgNotActive < Error; end
  class Error::OrgNameTooShort < Error; end
  class Error::ConnectionFailed < Error; end
end
