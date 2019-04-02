class ApplicationController < ActionController::Base
  #例外処理
  rescue_from ActiveRecord::RecordNotFound, with: :render404
  before_action :log_params, if: ->{Rails.env.development?}

  def render404
    render file: Rails.root.join("public/404.html"), layout: false, status: :not_found
  end

  def log_params
    Rails.logger.debug params.inspect
  end
end
