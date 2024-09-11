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
end
