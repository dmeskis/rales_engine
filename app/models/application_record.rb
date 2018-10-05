class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.single_finder(params)
    key = params.keys.first
    if key == 'created_at' || key == 'updated_at'
      date = DateTime.parse(params[key]).in_time_zone
      find_by(key => date)
    else
      find_by(params)
    end
  end

  def self.multi_finder(params)
    key = params.keys.first
    if key == 'created_at' || key == 'updated_at'
      date = DateTime.parse(params[key]).in_time_zone
      where(key => date)
    else
      where(params)
    end
  end

  def self.random_resource
    order("RANDOM()").limit(1).first
  end
end
