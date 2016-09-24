defmodule SampleApp.UserView do
  use SampleApp.Web, :view

  alias SampleApp.User
  alias SampleApp.Gravatar

  def get_gravatar_url(%User{email: email}) do
    Gravatar.get_gravatar_url(email, 50)
  end
end
