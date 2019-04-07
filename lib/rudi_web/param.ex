defimpl Phoenix.Param, for: Rudi.Drills.Seed do
  def to_param(%{public_id: public_id}) do
    "#{public_id}"
  end
end

defimpl Phoenix.Param, for: Rudi.Drills.Prompt do
  def to_param(%{public_id: public_id}) do
    "#{public_id}"
  end
end