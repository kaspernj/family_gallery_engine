class FamilyGallery::UsersController < FamilyGallery::BaseController
  load_and_authorize_resource

  def index
    @ransack_values = params[:q] || {}
    @ransack = FamilyGallery::User.ransack(@ransack_values)

    @users = @ransack.result
    @users = @users.order(:id).reverse_order unless @ransack_values[:s]
    @users = @users.page(params[:page])
  end

  def show
  end

  def new
  end

  def create
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_url
    else
      flash[:error] = @user.errors.full_messages.join(". ")
      redirect_to user_url(@user)
    end
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
