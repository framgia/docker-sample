class ApplicationController < ActionController::Base
  #例外処理
  rescue_from ActiveRecord::RecordNotFound, with: :render404
  rescue_from Exception, with: :render404

  def render404
    render template: 'public/404.html'
  end
end
