class CompanyResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :name
  attribute :url
  attribute :about
  attribute :email
  attribute :location
  attribute :links
  attribute :tech_stack
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :slug
  attribute :status
  attribute :about_tech

  # Associations
  attribute :categorizations
  attribute :categories
  attribute :user

  # Uncomment this to customize the display name of records in the admin area.
  # def self.display_name(record)
  #   record.name
  # end

  # Uncomment this to customize the default sort column and direction.
  # def self.default_sort_column
  #   "created_at"
  # end
  #
  # def self.default_sort_direction
  #   "desc"
  # end
end
