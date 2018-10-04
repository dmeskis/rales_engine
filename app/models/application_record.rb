class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search_single(params)
    key = params.keys.first
    if key == 'created_at' || key == 'updated_at'
      date = DateTime.parse(params[key])
      where(key => date).limit(1).first
    else
      find_by(params)
    end
  end
end
