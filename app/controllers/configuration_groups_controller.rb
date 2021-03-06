class ConfigurationGroupsController < ApplicationController
  before_action :set_configuration_group, only: [:show, :edit, :update, :destroy]

  def index
    @configuration_groups = ConfigurationGroup.all
  end

  def show
    @clients = @configuration_group.clients
  end

  def new
    @configuration_group = ConfigurationGroup.new
  end

  def edit
  end

  def create
    @configuration_group = ConfigurationGroup.new(configuration_group_params)

    if @configuration_group.save
      redirect_to @configuration_group, notice: 'Configuration group was successfully created.'
    else
      render :new
    end
  end

  def update
    if @configuration_group.update(configuration_group_params)
      redirect_to @configuration_group, notice: 'Configuration group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @configuration_group.destroy
    redirect_to configuration_groups_url, notice: 'Configuration group was successfully destroyed.'
  end

  private

    def set_configuration_group
      @configuration_group = ConfigurationGroup.find(params[:id])
    end


    def configuration_group_params
      params.require(:configuration_group).permit(:name)
    end
end
