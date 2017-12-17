defmodule SnappyWeb.SessionController do
  use SnappyWeb, :controller

  alias Snappy.Repo
  alias Snappy.Accounts.Auth


  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, session_params) do
    case Auth.login(session_params, Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:error, "Incorrect email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end


end
