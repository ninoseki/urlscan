module Spec
  module Support
    module Helpers
      module IOHelpers
        def capture(stream)
          begin
            stream = stream.to_s
            eval "$#{stream} = StringIO.new"
            yield
            result = eval("$#{stream}").string
          ensure
            eval("$#{stream} = #{stream.upcase}")
          end
          result
        end
      end
    end
  end
end