class SuggestionsController < ApplicationController
  # GET /suggestions
  def index
    @suggestions = Suggestion.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /suggestions/new
  def new
    @suggestion = Suggestion.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /suggestions
  def create
    @suggestion = Suggestion.new(params[:suggestion])

    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to suggestions_path, notice: 'Suggestion was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
end
