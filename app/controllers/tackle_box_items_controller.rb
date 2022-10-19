class TackleBoxItemsController < ApplicationController
  before_action :require_signin

  def index
    if item = current_user.tackle_box_item_for_most_recent_catch
      redirect_to action: :show, id: item
    else
      render :empty
    end
  end

  def show
    @item = current_user.tackle_box_items.find(params[:id])

    @items =
      current_user.tackle_box_items.
        order(created_at: :asc).includes(:bait)

    @new_catch = current_user.fish_catches.new(bait: @item.bait)

    @fish_catches =
      current_user.fish_catches.
        where(bait: @item.bait).order(created_at: :desc)
  end

  def create
    @bait = Bait.find(params[:bait_id])
    @item = current_user.tackle_box_items.create!(bait: @bait)

    # Não é necessário fazer o redirect, isso faz com que todo o html seja enviado para o frontend.
    # Sendo que só é necessário o frame que foi atualizado
    # redirect_to baits_url

    # só vamos renderizar o necessário
    @bait.my_tackle_box_item = @item

    # vamos parar de renderizar o partial _bait e deixar o rails renderizar a view create.turbo_stream
    # render @bait
  end

  def destroy
    @item = current_user.tackle_box_items.find(params[:id])
    @item.destroy

    # mesma coisa do create
    # redirect_to baits_url

    @bait = @item.bait
    render :create
  end

end
