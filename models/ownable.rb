module Ownable
  def owned_by? entity
    owner == entity || owner.owner == entity
  end
end
