class TestsController < Simpler::Controller

  def index
    #headers['Content-Type'] = 'text/plain'
    #render plain: "Some text"
    #@tests = Test.all
  end

  def create

  end

  def show
    @test = Test.find(params[:id])
  end

end
