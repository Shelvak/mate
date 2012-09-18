module MovementsHelper
  
  def change_movement_autocomplete_field_errors(obj)
    obj.attribute_names.each do |e|
      if obj.errors[e].present?
        id_match = e.match(/(\w+)_id/)
        attr_name = id_match[1] if id_match

        if obj.auto_attr_accessor_names.include? attr_name
          obj.errors.add("auto_#{attr_name}_name", obj.errors[e].join(', '))
          obj.errors[e].clear
        end
      end
    end
  end
end
