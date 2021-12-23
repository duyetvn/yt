module ErrorHandler
  extend ActiveSupport::Concern

  class YoutubeErrorHandleable < StandardError; end
end
