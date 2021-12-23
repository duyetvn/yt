class MoviesController < ApplicationController
  before_action :require_user_logged_in!, only: %i[new create]

  def index; end

  def new
    @movie = current_user.movies.new
  end

  def create # rubocop:disable Metrics/AbcSize
    @movie = current_user.movies.new(movie_params)
    if @movie.save
      flash[:success] = 'Your movie was added.'
      redirect_to root_path
    else
      flash.now[:error] = @movie.errors.full_messages
      @movie = current_user.movies.new(youtube_url: params[:movie][:youtube_url])
      render :new
    end
  rescue ErrorHandler::YoutubeErrorHandleable => e
    flash.now[:error] = e.message
    @movie = current_user.movies.new(youtube_url: params[:movie][:youtube_url])
    render :new
  end

  private

  def movie_params
    youtube_url = params[:movie] && params[:movie][:youtube_url]

    regex_url = %r{^.*(?:(youtu.be/)|(v/)|(/u/\w/)|(embed/)|(watch\?))\??v?=?([^#&?]*).*}
    unless youtube_url.match?(regex_url)
      raise ErrorHandler::YoutubeErrorHandleable, 'Invalid Youtube Url'
    end

    youtube_video_id = youtube_url.match(regex_url)[6]
    youtube_response = YoutubeServices::FetchingDetails.new(youtube_video_id).perform
    build_movie_params(youtube_response)
  end

  def build_movie_params(youtube_response)
    {
      youtube_id: youtube_response['items'][0]['id'],
      title: youtube_response['items'][0]['snippet']['title'],
      description: youtube_response['items'][0]['snippet']['description'],
      image_url: youtube_response['items'][0]['snippet']['thumbnails']['medium']['url']
    }
  end
end
