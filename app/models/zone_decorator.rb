Zone.class_eval do
  def include?(address)
    return false unless address

    # NOTE: This is complicated by the fact that include? for HMP is broken in Rails 2.1 (so we use awkward index method)
    members.any? do |zone_member|
      case zone_member.zoneable_type
      when "Zone"
        zone_member.zoneable.include?(address)
      when "Country"
        zone_member.zoneable_id == address.country_id
      when "City"
        address_city = nil
        
        if address.city.present? && address.state.present?
          address_city = City.find(
            :first, 
            :conditions => [
              'UPPER(name) = :name and state_id = :state_id', 
              { :name => address.city.upcase, :state_id => address.state.id }
            ]
          )
        end
        
        result = false
        if address_city.present?
          result = (zone_member.zoneable_id == address_city.id)          
        end
        result
      when "State"
        zone_member.zoneable_id == address.state_id
      else
        false
      end
    end
  end

  def kind
    member = self.members.last
    case member && member.zoneable_type
    when "City"   then "city"
    when "State"  then "state"
    when "Zone"   then "zone"
    else
      "country"
    end
  end

  def country_list
    members.map {|zone_member|
      case zone_member.zoneable_type
      when "Zone"
        zone_member.zoneable.country_list
      when "Country"
        zone_member.zoneable
      when "State"
        zone_member.zoneable.country
      when "City"
        zone_member.zoneable.country_list
      else
        nil
      end
    }.flatten.compact.uniq
  end
  
end