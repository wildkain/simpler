class TestsController < Simpler::Controller

  def index
    render plain: "Some string"
  end

  def create

  end

  def show
    @id = params[:id]
  end

end
