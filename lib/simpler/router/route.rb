module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @params = {}
      end

      def match?(method, path)
        @method == method && parse_string_path(path)
      end

      private

      def parse_string_path(path)
        router_path_slices = @path.split('/').reject!(&:empty?)
        request_path_slices = path.split('/').reject!(&:empty?)

        return false if request_path_slices&.size != router_path_slices.size

        router_path_slices.each_with_index do |slice, index|
          if parameter?(slice)
            add_params(slice, request_path_slices[index])
          else
            return false unless slice == request_path_slices[index]
          end
        end
      end

      def parameter?(parameter)
        parameter[0] == ':'
      end

      def add_params(parameter, value)
        parameter = parameter.delete(':').to_sym

        @params[parameter] = value.to_i.zero? ? value : value.to_i
      end

    end
  end
end
