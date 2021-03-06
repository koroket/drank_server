class DrinksController < ApplicationController

  def top
  	count = params[:count].to_i rescue 0
  	drinks = Drink.select("drinks.*, count(likes.id) AS likes_count").
	    joins("LEFT JOIN likes ON likes.drink_id = drinks.id").
	    group("drinks.id").
	    order("likes_count DESC").
	    limit(count)
	favorited_ids = current_user.favorites.select('drink_id').map(&:drink_id).uniq
	render :json => {
		status: 'success',
		drinks: drinks.map{|d| 
			d.as_json(only: [:id, :name, :img_url]).merge(
				{ 
					ingredients: d.drink_ingredients.map{
						|i| i.as_json(only: [:amount]).merge({ 
							name: i.ingredient.name 
						})
					},
					favorited: favorited_ids.include?(d['id'])
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

  def favorite
  	Favorite.find_or_create_by(user_id: current_user.id, drink_id: params[:drink_id])
  	render :json => {status: 'success'}
  end

  def unfavorite
  	favorite = Favorite.find_by(user_id: current_user.id, drink_id: params[:drink_id])
  	if favorite
  		favorite.destroy
  	end
  	render :json => {status: 'success'}
  end

  def favorite_list
  	if current_user
  		drinks = current_user.favorite_drinks
		render :json => {
			status: 'success',
			drinks: drinks.map{|d| 
				d.as_json(only: [:id, :name, :img_url]).merge(
					{ 
						ingredients: d.drink_ingredients.map{
							|i| i.as_json(only: [:amount]).merge({ 
								name: i.ingredient.name 
							})
						} 
					})
			}
		}
	else
      respond_to do |format|
        format.json { render :json => {status: 'error'} }
      end
	end
  end
end