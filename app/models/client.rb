class Client < ActiveRecord::Base

  validates_presence_of :client_key

  belongs_to :assigned_config, class_name: 'ClientConfiguration', foreign_key: 'assigned_config_id'
  belongs_to :last_config, class_name: 'ClientConfiguration', foreign_key: 'last_config_id'
  belongs_to :configuration_group

  before_save :assign_default_config


  def get_config(params={})
    config_count += 1
    last_config_time = Time.now
    last_config = assigned_config
    last_version = params[:user_agent] if params[:user_agent]
    save
    assigned_config.config_json
  end


  private

    def assign_default_config
      self.config_count = self.config_count.to_i
      if self.assigned_config_id.nil?
        self.assigned_config = self.configuration_group.default_config
      end
    end
end
