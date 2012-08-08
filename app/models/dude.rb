class Dude < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :ruby_gems_id
  has_many :affiliations, :dependent => :destroy
  has_many :projects, :through => :affiliations
  scope :featured, where(featured: true)
  scope :regular, where(featured: false)
  
  def bio
    super.blank? ? "..." : super
  end
  
  photo_options = {:styles => { :medium => "300x300>", :thumb => "100x100>" }}
  photo_options.merge!(storage: :s3,
    bucket: "seattlerb-org-#{Rails.env}",
    s3_credentials: {access_key_id: ENV["AWS_ACCESS_KEY_ID"], secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]}
  ) unless Rails.env.test?
  
  has_attached_file :photo, photo_options
  
end
