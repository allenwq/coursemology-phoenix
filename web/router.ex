defmodule Coursemology.Router do
  use Coursemology.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # Load current_user
    plug Coursemology.Auth, repo: Coursemology.Repo
    plug Coursemology.LoadAbility
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :course do
    plug Coursemology.LoadCourse
  end

  scope "/", Coursemology do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    scope "/users" do
      get    "/sign_in",  SessionController, :new
      post   "/sign_in",  SessionController, :create
      get "/sign_out", SessionController, :delete
    end

    resources "/courses", CourseController do
      pipe_through :course
      resources "/announcements", AnnouncementController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Coursemology do
  #   pipe_through :api
  # end
end
