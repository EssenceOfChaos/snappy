defmodule Snappy.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Snappy.Accounts.{User, Encryption}


  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :username, :string
    ## Virtual Fields ##
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @required_fields ~w(email username password)
  @optional_fields ~w()


  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> downcase_email
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)
    if password do
    encrypted_password = Encryption.hash_password(password)
    put_change(changeset, :password_hash, encrypted_password)
    else
    changeset
    end
  end

  defp downcase_email(changeset) do
    update_change(changeset, :email, &String.downcase/1)
  end

end
