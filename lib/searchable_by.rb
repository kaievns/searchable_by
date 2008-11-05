module SearchableBy
  def searchable_by(*args)
    # getting the additional options hash
    options = (args.size > 1 and args.last.is_a?(Hash)) ? args.pop : { }
    
    method_name = options[:method_name] || 'like'
    options.delete :method_name
    
    # getting the fields definition
    unless args.first.is_a?(Hash)
      fields = { }
      args.each do |field|
        fields[field] = :like
      end
    else
      fields = args.first
    end
    
    # compiling the conditions block
    module_eval <<-"end_eval"
      named_scope :#{method_name}, lambda{ |search|
  
      }
    end_eval
  end
end
