defmodule FbRanker.Facebook.Page do
  use Ecto.Schema
  import Ecto.Changeset
  alias FbRanker.Facebook.Page


  schema "pages" do
    field :about, :string
    field :fan_count, :integer
    field :name, :string
    field :page_id, :string
    field :category, :string
    has_many :posts, FbRanker.Facebook.Post

    timestamps()
  end

  @doc false
  def changeset(%Page{} = page, attrs) do
    page
    |> cast(attrs, [:name, :about, :category, :page_id, :fan_count])
    |> validate_required([:name, :about, :page_id, :fan_count])
  end
end
