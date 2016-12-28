module Calabash
  # A base class for the Page Object Model (POM) or Page Object Pattern.
  #
  # We recommend the POM for testing cross-platform apps.
  #
  # @example
  #  # You must have a page for the platforms you target
  #  class Android::MyPage < Calabash::Page
  #    # ...
  #  end
  #
  #  cal.page(MyPage).await
  #
  # We have a great examples of using the POM in the Calabash 2.0 repository.
  #   * https://github.com/calabash/calabash/tree/develop/samples/shared-page-logic
  class Page
    # @!visibility private
    def self.inherited(subclass)
      unless subclass.superclass.name == "Calabash::Page"
        raise TypeError, ["#{subclass} cannot inherit from #{subclass.superclass}.",
                          " Can only inherit directly from Calabash::Page"].join("")
      end
    end

    def self.new(*args)
      instance = allocate
      # Freeze the instance
      instance.freeze
      instance.send(:initialize, *args)
      instance
    end

    # @!visibility private
    def initialize
    end

    # A query that identifies your page. This method is used by
    # {Calabash::Page#await await}.
    #
    # @example
    #  class HomePage < Calabash::Page
    #    def trait
    #      {id: 'home'}
    #    end
    #  end
    #
    #  cal.page(HomePage).await # Uses `trait`
    #
    # @return [String, Hash, Calabash::Query] A query identifying the page.
    def trait
      raise 'Implement your own trait'
    end

    # Waits for the view identified by the page {Calabash::Page#trait trait} to
    # appear.
    #
    # @note If you need a more precise waiting method for a page, then
    #  just overwrite this method.
    #
    # @param [Number] timeout (default: {Calabash::Wait.default_options
    #  Calabash::Wait.default_options[:timeout]}) The time to continuously
    #  query before failing.
    # @raise [Calabash::Wait::UnexpectedMatchError] if no view matching
    #  {Calabash::Page#trait trait} is found within `timeout`.
    def await(timeout: Calabash::Wait.default_options[:timeout])
      timeout_message = lambda do |wait_options|
        "Timed out waiting for page #{self.class}: Waited #{wait_options[:timeout]} seconds for trait #{trait} to match a view"
      end

      cal.wait_for_view(trait, timeout: timeout, timeout_message: timeout_message)
    end

    # @!visibility private
    class StubPage

    end
  end
end
