defmodule LiveRatingWeb.TemperatureComponent do
  use Phoenix.Component

  # Optionally also bring the HTML helpers
  # use Phoenix.HTML

  def greet(assigns) do
    ~H"""
    <p>Phoenix Component! Hello, <%= assigns.name %> Temperature change <%= assigns.count %>&#8457</p>
    """
  end
end
