defmodule FbRanker.Accounts.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias FbRanker.Accounts.Group


  schema "groups" do
    field :description, :string
    field :name, :string
    many_to_many :pages, FbRanker.Facebook.Page, join_through: "group_pages"

    timestamps()
  end

  @doc false
  def changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
