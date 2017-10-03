defmodule FbRanker.Facebook.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias FbRanker.Facebook.Post


  schema "posts" do
    field :created_time, :string
    field :fb_id, :string
    field :likes, :integer
    field :message, :string
    field :shares, :integer
    field :page_id, :string
    field :story, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:message, :story, :created_time, :fb_id, :shares, :likes, :page_id])
    |> validate_required([:message, :story, :created_time, :fb_id, :shares, :likes, :page_id])
  end
end
