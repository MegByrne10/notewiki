class WikiPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(private: false)
    end
  end

  def index?
    true
  end

  def new?
    user.present?  
  end

  def create?
    if record.private
      user.present? && user.subscribed
    else
      user.present? 
    end
  end

  def edit?
    if record.private
      user.present? && user.subscribed && record.user == user
    else
      user.present? 
    end
  end

  def update?
    create?    
  end

  def show?
    edit?    
  end
end
