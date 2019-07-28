class BoxDesignController < ApplicationController
  before_action :authenticate_user!

  def new
  end
  
  def claim
    @box = box_claim_scope.find(params[:box_id])
    # todo: check here that there doesnt already exist one
    # if it has_designer? already
    # redirect page
    # else set the below
    @box.designed_by = current_user
    # and redirect to the box design page
    @box.save!
  end

  def mark_as_designed
    @box = box_claim_scope.find_by(designed_by: current_user)
    @box.update(box_design_params)
  end

  private

  def box_design_params
    require(:box)
  end

  def box_claim_scope
    policy_scope(Box, policy_scope_class: BoxPolicy::DesignScope)
  end
end
