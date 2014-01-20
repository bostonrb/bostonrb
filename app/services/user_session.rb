class UserSession
  def initialize(organization_permission, pnc_permission)
    @organization_permission = organization_permission
    @pnc_permission = pnc_permission
  end

  def to_hash
    {organizer: @organization_permission,
    project_night_coordinator: @pnc_permission}
  end
end
