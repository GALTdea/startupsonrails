class LogoService
  include ApplicationHelper

  def initialize(company)
    @company = company
    @s3_service = S3Service.new
  end

  def s3_logo_url(classes: "", height: '24', width: '24')
    object_key = "/company_logos/#{@company.name.downcase.gsub(/\s+/, '_')}_logo.png"

    if @s3_service.object_key_exists?(object_key)
      @s3_service.presigned_url(object_key)
    else
      generate_svg_with_initials(@company.name, classes, height, width)
    end
  end
end
