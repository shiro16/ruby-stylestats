class StyleStats
  class BaseError < StandardError
  end

  class RequestError < BaseError
  end

  class ContentError < BaseError
  end

  class InvalidError < BaseError
  end
end
