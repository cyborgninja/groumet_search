class SearchesController < ApplicationController
  #before_action :get_mechanize, only: :result

  def index
    @searches = Search.all
  end

  def result
    agent = Mechanize.new
    page = agent.get(params[:url])
    @url = params[:url].force_encoding("utf-8")
    @count = page.search('.rvw-item__rvw-title-target').count

    @result_review_url = Array.new
    review_url = page.search('.rvw-item__rvw-title-target')
    review_url.each do |r|
      @result_review_url.push r[:href]
    end
    
    innertext = page.search('.rvw-item__rvw-comment.js-rvw-comment').inner_text
    @result = innertext.split("もっと見る")
  end

  def get_mechanize
    agent = Mechanize.new
    page = agent.get(params[:url])
    puts page.body
    # url = 'http://www.google.co.jp'
    # page = agent.get(url)
  end
end
