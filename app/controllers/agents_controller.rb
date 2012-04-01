class AgentsController < ApplicationController
    def index
        @agents = Agent.limit(10).all

        respond_to do |format|
          format.html  # index.html.erb
          format.json  { render :json => @agents }
        end
    end
end
