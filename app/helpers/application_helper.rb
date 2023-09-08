module ApplicationHelper
  include Pagy::Frontend

  def generate_svg_with_initials(name)
    initials = name[0..1].upcase
    svg_html = <<-SVG
      <svg width="50" height="50" class="company-logo">
        <rect width="100%" height="100%" fill="#eee" />
        <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" font-size="24px" font-family="Arial">
          #{initials}
        </text>
      </svg>
    SVG
    svg_html.html_safe
  end
end
