module MovementsHelper

  def change_movement_autocomplete_field_errors(obj)
    obj.errors.add(:auto_bank_name, obj.errors[:bank_id].join(', '))
    obj.errors[:bank_id].clear
  end
end
