module ApplicationHelper
  include Pagy::Frontend

  def generate_svg_with_initials(name, classes = '', height = '', width = '')
    initials = name[0..1].upcase
    svg_html = <<-SVG
      <svg width="#{width}" height="#{height}" viewBox="0 0 100 100" class="company-logo align-middle rounded shadow-md #{classes}">
        <rect width="100%" height="100%" />
        <text x="50" y="50" dominant-baseline="middle" text-anchor="middle" font-size="3em" font-family="Arial">
          #{initials}
        </text>
      </svg>
    SVG
    svg_html.html_safe
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

  def company_logo_placeholder(company, size: 150)
    # Generate a color based on the company name
    hue = company.name.sum % 360
    color1 = "hsl(#{hue}, 70%, 60%)"
    color2 = "hsl(#{(hue + 40) % 360}, 70%, 60%)"

    # Get company initials
    initials = company.name.split.map(&:first).join[0, 2].upcase

    # Create SVG
    svg_content = <<~SVG
      <svg width="#{size}" height="#{size}" xmlns="http://www.w3.org/2000/svg">
        <defs>
          <linearGradient id="grad_#{company.id}" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#{color1};stop-opacity:1" />
            <stop offset="100%" style="stop-color:#{color2};stop-opacity:1" />
          </linearGradient>
        </defs>
        <rect width="100%" height="100%" fill="url(#grad_#{company.id})" />
        <text x="50%" y="50%" font-family="Arial, sans-serif" font-size="#{size / 2}px" fill="white" text-anchor="middle" dy=".3em">#{initials}</text>
      </svg>
    SVG

    svg_content.html_safe
  end
end
