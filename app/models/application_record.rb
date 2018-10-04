class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.find_record_by(params)
    param = params.keys.first
    if param == 'created_at' || param == 'updated_at'
      date = DateTime.parse(params[param])
      where(param => date).limit(1).first
    else
      find_by(params)
    end
  end
end
