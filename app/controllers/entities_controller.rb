class EntitiesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @entities = Entity.all.where(category_id: params[:group_id])
  end

  def new
    @groups = Group.all.where(author: current_user.id)
    @group = Group.find(params[:group_id])
    @entity = Entity.new
  end

  def create
    @group = Group.find(params[:group_id])
    @category = Group.find(params[:category_id]) # replace with the actual way to get the category
    @entity = @category.entities.build(entity_params.merge(author_id: current_user.id, category: @category))

    if @entity.save
      redirect_to group_entities_path(@group), notice: 'Entity was successfully created.'
    else
      @groups = Group.all.where(author: current_user.id)
      puts @entity.errors.full_messages
      render :new, notice: 'Entity Not created.'
    end
  end

  private

  def entity_params
    params.require(:entity).permit(:name, :amount, :category_id, :author_id)
  end
end
