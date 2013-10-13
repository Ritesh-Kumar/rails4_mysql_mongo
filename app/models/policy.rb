class Policy < ActiveRecord::Base
  scope :sorting, lambda{ |options|
    attribute = options[:attribute]
    direction = options[:sorting]

    attribute ||= "id"
    direction ||= "DESC"

    order("#{attribute} #{direction}")
  }

  include BeautifulScaffoldModule
  before_save :fulltext_field_processing

  validates_presence_of :name

  # You can OVERRIDE this method used in model form and search form (in belongs_to relation)
  def caption
    (self["name"] || self["label"] || self["description"] || "##{id}")
  end

  def fulltext_field_processing
    # You can preparse with own things here
    generate_fulltext_field(["description"])
  end

  def self.permitted_attributes
    return :name,:description,:company,:address,:start_date,:end_date,:status,:amount,:interest_rate,:time_period
  end
end
