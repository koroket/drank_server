class SubscriptionsController < ApplicationController
    
  def list
  	if current_user
  		subscribed_ids = current_user.subscriptions.select('category_id').map(&:category_id).uniq
		respond_to do |format|
			format.json { 
				render :json => {
					status: 'success',
					categories: Category.all.map{|c| c.as_json(only: [:id, :name]).merge({ subscribed: subscribed_ids.include?(c['id'])})}
				} 
			}
		end
	else
      respond_to do |format|
        format.json { render :json => {status: 'error'} }
      end
	end
  end

  def subscribed
  	if current_user
		respond_to do |format|
			format.json { 
				render :json => {
					status: 'success',
					categories: current_user.categories.map{|c| c.as_json(only: [:id, :name])}
				} 
			}
		end
	else
      respond_to do |format|
        format.json { render :json => {status: 'error'} }
      end
	end
  end

  def subscribe
    if current_user
    	category = Category.find_by_id(params[:category_id]) rescue nil
    	return render :json => {status: 'error'} unless category
    	subscription = Subscription.find_or_create_by(category_id: category.id, user_id: current_user.id)
    	category.drinks.each do |d|
    		Recommendation.find_or_create_by(subscription_id: subscription.id, drink_id: d.id)
    	end
		respond_to do |format|
			format.json { 
				render :json => {
					status: 'success'
				} 
			}
		end
	else
      respond_to do |format|
        format.json { render :json => {status: 'error'} }
      end
	end
  end
end