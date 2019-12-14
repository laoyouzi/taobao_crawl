class AdminConstraint
  def matches? request
    request.env['warden'].user&.admin?
  end
end
