# config/initializers/fix_rails_2076
require 'builder'

module Builder
  class XmlBase
    # We aren't under Ruby 1.9?
    unless ::String.method_defined?(:encode)
      def _escape(text)
        text.to_xs
      end
    end
  end
end
