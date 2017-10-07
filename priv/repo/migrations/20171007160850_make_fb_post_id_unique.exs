defmodule FbRanker.Repo.Migrations.MakeFbPostIdUnique do
  use Ecto.Migration

  def change do
    create unique_index(:posts, [:fb_id])
  end
end
