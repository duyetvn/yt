module YoutubeServices
  class FetchingDetails
    def initialize(youtube_video_id)
      @youtube_video_id = youtube_video_id
    end

    def perform # rubocop:disable Metrics/AbcSize
      url = URI("https://www.googleapis.com/youtube/v3/videos?part=id%2C+snippet&id=#{@youtube_video_id}&key=#{Rails.application.credentials.youtube_api_key}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      response = https.request(request)
      if response.code.to_i == 400
        raise ErrorHandler::YoutubeErrorHandleable, response['error']['message']
      end

      body_response = JSON.parse(response.read_body)
      if body_response['items'].blank?
        raise ErrorHandler::YoutubeErrorHandleable, 'Not found video on youtube.'
      end

      body_response
    end
  end
end
