class FamilyGallery::ResourcesController < FamilyGallery::BaseController
  # Set load_and_authorize for classes that extend this one.
  def self.inherited(subclass)
    name_match = subclass.name.match(/\AFamilyGallery::(.+)sController\Z/)
    class_name = "FamilyGallery::#{name_match[1]}"
    subclass.load_and_authorize_resource class_name: class_name

    subclass.__send__(:define_method, :resource_name) do
      name_match[1]
    end
  end

  def index
    @ransack = resource_class.ransack(params[:q])
  end

  def new
    assign_params_to_resource_instance
  end

  def create
    assign_params_to_resource_instance

    if resource_instance.save
      redirect_to resource_instance
    else
      render :new
    end
  end

  def show
  end

  def edit
    assign_params_to_resource_instance
  end

  def update
    assign_params_to_resource_instance

    if resource_instance.save
      redirect_to resource_instance
    else
      render :edit
    end
  end

  def destroy
    if resource_instance.destroy
      redirect_to root_url
    else
      flash[:error] = resource_instance.errors.full_messages.join(". ")
      redirect_to resource_instance
    end
  end

private

  def resource_class
    FamilyGallery.const_get(resource_name)
  end

  def resource_instance
    unless @resource_instance
      @resource_instance = instance_variable_get("@#{StringCases.camel_to_snake(resource_name)}")
    end

    @resource_instance
  end

  def resource_extracted_params
    key_name = StringCases.camel_to_snake(resource_name)
    return params[key_name]
  end

  def assign_params_to_resource_instance
    resource_instance.assign_attributes(resource_params) if resource_extracted_params
    after_assign
  end
end
