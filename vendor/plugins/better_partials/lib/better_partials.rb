module BetterPartials
  module Helpers
    
    # Renders a Partial intelligently
    # 
    # Normal partial call:
    #  <%= partial "my_partial" %>
    # same as...
    #  <%= render :partial => "my_partial" %>
    # 
    # Partial call with arguments:
    #  <%= partial "my_partial", :arg1 => "test" %>
    # same as...
    #  <%= render :partial => "my_partial", :locals => {:arg1 => "test"}  %>
    # 
    # Partial call with collection (and arguments)
    #  <%= partial "my_partial", :collection => @items, :arg1 => "test" %>
    #  same as...
    #  <%= render :partial => "my_partial", :collection => @items, :locals => {:arg1 => "test", :collection => @items} %>
    # 
    # Partial also supports blocks naturally
    # <% partial "my_partial", :collection => @items, :arg1 => "test" do %>
    #   inner partial content
    # <% end %>
    # same as...
    # <% render :layout => "my_partial", :collection => @items, :arg1 => "test" do %>
    #   inner partial content
    # <% end %>
    def partial(partial_path, options = {}, &block)

      # partial_options will build up the hash parameter to pass into render()
      partial_options = {}
      
      # partial_locals will build up the hash parameter to pass into the :locals option
      partial_locals = {}

      # setup partial path
      partial_options[:partial] = partial_path
    
      # handle case where options is a straight up active record model
      if options.is_a? ActiveRecord::Base
        partial_options[:object] = options
      else      
        # find all the special options to passoff to render (the rest we'll put in :locals)
        passoff_options = [
          :collection,
          :spacer_template,
          :object, 
          :use_full_path
        ]
        
        # cycle through and add these options directly to partial_options
        passoff_options.each do |passoff_option|
          # only assign if passoff option exists
          if options.has_key?(passoff_option)
            # move the option from options to partial_options
            partial_options[passoff_option] = options.delete(passoff_option)
          end
        end
            
        # move whats left of the remaining options into partial_locals
        partial_locals = options.merge(partial_locals)
      end
    
      # set partial locals
      partial_options[:locals] = partial_locals
      if block_given?
        # swap layout and partial options
        partial_options[:layout] = partial_options.delete(:partial)

        # render the partial
        render(partial_options, &block)

        # return nothing since render :layout will write directly to EROUT
        return nil
      else
        # normal render call
        return render(partial_options)
      end
    end
    
    # make it more suh-man-tech
    # e.g. partials @people
    def partials(collection)
      partial(collection) if collection
    end
  end
end