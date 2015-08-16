class CategoriesController < ApplicationController
    
  def recommend_drink
  	subscription = Subscription.find_by(user_id: current_user.id, category_id: params[:category_id]) rescue nil
  	return render :json => {status: 'error'} unless subscription

	liked_ids = subscription.likes.select('drink_id').map(&:drink_id).uniq
	disliked_ids = subscription.dislikes.select('drink_id').map(&:drink_id).uniq

	drinks = subscription.drinks.
    joins("LEFT JOIN dislikes ON dislikes.subscription_id = #{subscription.id} AND dislikes.drink_id = drinks.id").
    group("drinks.id").
    having("count(dislikes.id) < ?",1)

   	drink = drinks.select("drinks.*, count(likes.id) AS likes_count").
    joins("LEFT JOIN likes ON likes.drink_id = drinks.id").
    group("drinks.id").
    order("likes_count DESC").
    limit(1).first rescue nil

    if drink
		return render :json => {
			status: 'success',
			drink: drink.as_json(only: [:id, :name]).merge(
				{ 
					ingredients: drink.drink_ingredients.map{
						|i| i.as_json(only: [:amount]).merge({ 
							name: i.ingredient.name 
						})
					},
					liked: liked_ids.include?(drink['id']),
					disliked: disliked_ids.include?(drink['id'])
				})
		}
    else 
	    return render :json => {
			status: 'success',
			drink: subscription.drinks.order("RANDOM()").first.as_json(only: [:id, :name]).merge(
				{ 
					ingredients: drink.drink_ingredients.map{
						|i| i.as_json(only: [:amount]).merge({ 
							name: i.ingredient.name 
						})
					},
					liked: liked_ids.include?(drink['id']),
					disliked: disliked_ids.include?(drink['id']) 
				})
		}
    end
  end
end