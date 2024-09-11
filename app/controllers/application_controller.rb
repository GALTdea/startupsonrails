class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization

  helper_method :page_description, :page_image_url

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def page_description
    @page_description || 'Discover and learn about startups built with Ruby on Rails'
  end

  def page_image_url
    @page_image_url || default_svg_image_url
  end

  def default_svg_image_url
    svg = <<-SVG
      <svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200">
        <rect width="200" height="200" fill="#f0f0f0"/>
        <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" font-family="Arial, sans-serif" font-size="24" fill="#333">
          StartUpsOnRails
        </text>
      </svg>
    SVG

    "data:image/svg+xml;base64,#{Base64.strict_encode64(svg)}"
  end
end
