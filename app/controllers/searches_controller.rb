class SearchesController < ApplicationController
  before_action :get_mechanize, except: :index

  def index; end

  def result_tabelog
    #店舗名
    @title = @page.at('.display-name').inner_text
    #レビュー数カウント
    @count = @page.search('.rvw-item__rvw-title-target').count
    #レビューの個別URL
    @result_review_url = Array.new
    review_url = @page.search('.rvw-item__rvw-title-target')
    review_url.each do |r|
      @result_review_url.push r[:href]
    end
    #レビューの文章
    innertext = @page.search('.rvw-item__rvw-comment.js-rvw-comment p')
    @result = innertext
  end

  def result_retty
    #店舗名
    @title = @page.at('.overview__name.l-height-xs').inner_text
    #レビュー数カウント
    @count = @page.search('.frame.frame-type-1.mb10').count
    #レビューの個別URL
    @result_review_url = Array.new
    review_url = @page.search('.box__right > span > a')
    review_url.each do |r|
      @result_review_url.push r[:href]
    end
    #レビューの文章
    innertext = @page.search('.frame.frame-type-1.mb10 > .mt15.mb15')
    @result = innertext
  end

  private
    def get_mechanize
      agent = Mechanize.new
      @page = agent.get(params[:url])
      @url = params[:url].force_encoding("utf-8")
    end
end
