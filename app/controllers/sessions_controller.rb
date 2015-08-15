class SessionsController < ApplicationController
    
  def new
  end
    
  def create
    user = User.find_or_create_by(fbid:params[:fbid])
    if user.valid?
      log_in user
      respond_to do |format|
        format.json { render :json => {status: 'success'} 
        }
      end
    else
      respond_to do |format|
        format.json { render :json => {status: 'error'} }
      end
    end
  end
    
  def destroy
    if current_user
      log_out
      respond_to do |format|
        format.json { render :json => {status: 'success'} 
        }
      end
    else
      respond_to do |format|
        format.json { render :json => {status: 'error'} }
      end
    end
  end
end