class AppsController < ApplicationController
  def index
    @apps = App.where(:user_id => current_user.id)
  end

  def new
    @app = App.new
  end

  def create
    @app = App.new(app_params)
    @app.url = remove_back_slash(@app.url)
    @app.user_id = current_user.id

    if validate_uri(@app.url) && @app.valid?
      @app.save
      redirect_to root_path, notice: 'saved'
    else
      render :new
    end
  end

  def show
    @app = App.find(params[:id])
    @payments = Payment.where(app_id: @app)
  end

  def destroy
    @app = App.find(params[:id])

    if @app.destroy
      redirect_to root_path, notice: 'done'
    else
      render :show
    end
  end

  private

  def app_params
    params.require(:app).permit(:name, :url, :user_id)
  end

  def remove_back_slash(uri)
    uri[-1] == '/' ? uri = uri[0...-1] : nil
    uri
  end

  def validate_uri(uri)
    uri = URI.parse(uri)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS) && uri.host != nil
  end
end
