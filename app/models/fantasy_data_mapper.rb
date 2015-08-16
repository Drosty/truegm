module FantasyDataMapper 
  
  def init_from_import_model in_model
    in_model.attrs.each do |attribute|
      send("#{attribute[0].to_sym}=", attribute[1]) if has_attribute?(attribute[0].to_sym)      
    end
  end

end
