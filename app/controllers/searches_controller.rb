class SearchesController < ApplicationController
  before_action :get_mechanize, only: :result_tabelog

  def index; end

  def result_tabelog
    @title = @page.at('.display-name').inner_text
    @count = @page.search('.rvw-item__rvw-title-target').count

    @result_review_url = Array.new
    review_url = @page.search('.rvw-item__rvw-title-target')
    review_url.each do |r|
      @result_review_url.push r[:href]
    end
    
    innertext = @page.search('.rvw-item__rvw-comment.js-rvw-comment p')
    @result = innertext
  end

  private
    def get_mechanize
      agent = Mechanize.new
      @page = agent.get(params[:url])
      @url = params[:url].force_encoding("utf-8")
    end
end
