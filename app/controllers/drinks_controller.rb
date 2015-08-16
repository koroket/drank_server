class DrinksController < ApplicationController

  def top
  	count = params[:count].to_i rescue 0
  	drinks = Drink.select("drinks.*, count(likes.id) AS likes_count").
	    joins("LEFT JOIN likes ON likes.drink_id = drinks.id").
	    group("drinks.id").
	    order("likes_count DESC").
	    limit(count)
	render :json => {
		status: 'success',
		drinks: drinks.map{|d| 
			d.as_json(only: [:id, :name]).merge(
				{ 
					ingredients: d.drink_ingredients.map{
						|i| i.as_json(only: [:amount]).merge({ 
							name: i.ingredient.name 
						})
					} 
				})
		}
	} 
  end

  def like
    subscription = Subscription.find_by(user_id: current_user.id, category_id: params[:category_id]) rescue nil
  	return render :json => {status: 'error'} unless subscription
  	like = Like.find_or_create_by(subscription_id: subscription.id, drink_id: params[:drink_id])
  	dislike = Dislike.find_by(subscription_id: subscription.id, drink_id: params[:drink_id]) rescue nil
  	if dislike
  		dislike.destroy
  	end
  	render :json => {status: 'success'}
  end

  def dislike
    subscription = Subscription.find_by(user_id: current_user.id, category_id: params[:category_id]) rescue nil
  	return render :json => {status: 'error'} unless subscription
  	dislike = Dislike.find_or_create_by(subscription_id: subscription.id, drink_id: params[:drink_id])
  	like = Like.find_by(subscription_id: subscription.id, drink_id: params[:drink_id]) rescue nil
  	if like
  		like.destroy
  	end
  	render :json => {status: 'success'}
  end
end