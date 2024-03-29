class PicturesController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :missing_parameter
  before_action :set_picture, only: %i[destroy]
  before_action :set_event, only: %i[create destroy]

  def create
    @new_picture = @event.pictures.build(picture_params)
    @new_picture.user = current_user

    if @new_picture.save
      redirect_to @event, notice: I18n.t("controllers.pictures.created")
    else
      render "events/show", alert: I18n.t("controllers.pictures.error")
    end
  end

  def destroy
    if current_user_can_edit?(@picture)
      @picture.destroy
      message = { notice: I18n.t("controllers.pictures.destroyed") }
    else
      message = { alert: I18n.t("controllers.pictures.error") }
    end

    redirect_to @event, message
  end

  private

  def picture_params
    params.require(:picture).permit(:photo)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def missing_parameter
    message = { alert: I18n.t("controllers.pictures.missing") }
    redirect_to @event, message
  end
end
