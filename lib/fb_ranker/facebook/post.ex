defmodule FbRanker.Facebook.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias FbRanker.Facebook.Post


  schema "posts" do
    field :created_time, :string
    field :fb_id, :string
    field :likes, :integer
    field :comments, :integer
    field :message, :string
    field :type, :string
    field :shares, :integer
    belongs_to :page, FbRanker.Facebook.Page
    field :story, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:message, :story, :type, :created_time, :fb_id, :shares, :likes, :page_id, :comments])
    |> validate_required([:created_time, :fb_id, :shares, :likes, :comments, :page_id])
  end
end
