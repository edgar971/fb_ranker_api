defmodule FbRanker.Repo.Migrations.MakePageIdUnique do
  use Ecto.Migration

  def change do
    create unique_index(:pages, [:page_id])
  end
end
