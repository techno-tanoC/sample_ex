defmodule SampleApp.UserController do
  use SampleApp.Web, :controller

  def show(conn, %{"id" => id}) do
    user = User |> get(id)
    render(conn, "show.html", user: user)
  end

  def new(conn, _params) do
    render(conn, "new.html", changeset: User.new)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    if changeset.valid? do
      case insert(changeset) do
        {:ok, _} ->
          conn
          |> put_flash(:info, "User registration is success!!")
          |> redirect(to: static_pages_path(conn, :home))
        {:error, result} ->
          render(conn, "new.html", changeset: result)
      end
    else
      render(conn, "new.html", changeset: changeset)
    end
  end
end
