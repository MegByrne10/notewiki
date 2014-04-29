class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?    
  end

  def update?
    create?    
  end

  def show?
    record.private? == false || (record.private? && ( user.subcribed? && ( record.user_id == user.id ) ))    
  end
end
