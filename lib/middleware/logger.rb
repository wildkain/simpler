require 'logger'

class AppLogger

  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    @logger.info(log_format(env, status, headers))
    [status, headers, response]
  end

  private

  def log_format(env, status, headers)
    @logger.formatter = proc do
      "Time: #{Time.now}\n"\
      "Request: #{env['REQUEST_METHOD']} #{env['REQUEST_URI']}\n"\
      "Handler: #{env['simpler.controller'].name.capitalize}Controller##{env['simpler.action']}\n"\
      "Parameters: #{env['simpler.controller'].send :params}\n"\
      "Response: #{status} #{headers['Content-Type']} #{env['simpler.view_path']}\n\n"
    end
  end

end