class CommentsController < ApplicationController
	
	def index
		@comments = Comment.where(:group_id => params[:group_id])
		@group = Group.find(params[:group_id])
		@title = "Comments"
	end

	def new
		@comment = Comment.new(:group_id => params[:group_id])
		@title = "Comments"
	end

	def create
    #spam catch to redirect - maybe the bots were ignoring the spam field
    redirect_to groups_url and return if comments_params[:username].present?

		@comment = Comment.new(comments_params)

    respond_to do |format|
    	if @comment.save
    		format.html {redirect_to groups_path, notice: 'Thank you for commenting.' }
    	else
    		format.html { render action: "new" }
    	end
    end
	end

	private

	def comments_params
		params.require(:comment).permit(:body, :member, :group_id, :username)
	end
end
