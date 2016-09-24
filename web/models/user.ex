defmodule SampleApp.User do
  use SampleApp.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_digest, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @required_fields ~w(name email password)a
  @optional_fields ~w()a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_presence(:name)
    |> validate_presence(:email)
    |> validate_format(:email, ~r/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
    |> unique_constraint(:name)
    |> unique_constraint(:email)
    |> validate_length(:name, min: 1)
    |> validate_length(:name, max: 50)
  end

  def insert_changeset(struct, params \\ %{}) do
    changeset(struct, params) |> set_password_digest
  end

  defp set_password_digest(changeset) do
    digest  =
      Ecto.Changeset.get_field(changeset, :password)
      |> SampleApp.Encryption.encrypt
    put_change(changeset, :password_digest, digest)
  end
end
