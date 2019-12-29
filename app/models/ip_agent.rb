class IpAgent < ApplicationRecord

  scope :active_agent, ->{
    where(active: true).first
  }
end
