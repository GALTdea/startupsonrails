module ApplicationHelper
  include Pagy::Frontend

  def generate_svg_with_initials(name)
    initials = name[0..1].upcase
    svg_html = <<-SVG
      <svg width="70" height="70" viewBox="0 0 100 100" class="company-logo align-middle ">
        <rect width="100%" height="100%" fill="#007bff" />
        <text x="50" y="50" dominant-baseline="middle" text-anchor="middle" font-size="3em" font-family="Arial">
          #{initials}
        </text>
      </svg>
    SVG
    svg_html.html_safe
  end
end

# <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false">
#   <title>Placeholder</title>
#   <rect width="100%" height="100%" fill="#007bff"></rect>
#   <text x="50%" y="50%" fill="#007bff" dy=".3em">32x32</text>
# </svg>