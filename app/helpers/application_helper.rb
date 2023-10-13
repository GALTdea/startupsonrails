module ApplicationHelper
  include Pagy::Frontend

  def generate_svg_with_initials(name)
    initials = name[0..1].upcase
    svg_html = <<-SVG
      <svg viewBox="0 0 100 100" class="company-logo align-middle ">
        <rect width="100%" height="100%" fill="#007bff" />
        <text x="50" y="50" dominant-baseline="middle" text-anchor="middle" font-size="3em" font-family="Arial">
          #{initials}
        </text>
      </svg>
    SVG
    svg_html.html_safe
  end
end