class Setting < ActiveRecord::Base
  validates_presence_of :key, :value
  validates_uniqueness_of :key

  def self.[](key)
    setting = find_by_key(key)
    setting.nil? ? nil : setting.value
  end

  def self.[]=(key, value)
    setting = find_by_key(key)

    if setting
      setting.value = value
    else
      setting = new(:key => key, :value => value)
    end

    setting.save
  end
end
