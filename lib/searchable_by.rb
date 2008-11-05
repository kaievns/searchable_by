module SearchableBy
  def searchable_by(*args)
    # getting the fields definition
    unless args.first.is_a?(Hash)
      fields = { }
      args.each do |field|
        fields[field] = :like
      end
    else
      fields = args.first
    end
    
    # getting the name-scope name
    method_name = fields[:method_name] || 'like'
    fields.delete :method_name
    
    # compiling the conditions block
    module_eval <<-"end_eval"
      named_scope :#{method_name}, lambda{ |search| {
        :conditions => [#{
          conditions = []
          values = []

          fields.each do |field, type|
            field = field.to_s
            type = type.to_s.downcase

            field = table_name + "." + field unless field.include?('.')

            conditions << case type
                            when 'exact_i' then "LOWER(#{field}) = LOWER(?)" 
                            when 'exact'   then "#{field} = ?"
                            else                "#{field} LIKE ?"
                          end

            values << case type
                        when 'exact', 'exact_i' then 'search'
                        when 'begin'            then '"#{search}%"'
                        when 'end'              then '"%#{search}"'
                        else                         '"%#{search}%"'
                      end
          end

          '"'+ conditions.join(' OR ') +'", '+ values.join(', ')
        }]
      }}
    end_eval
  end
end
