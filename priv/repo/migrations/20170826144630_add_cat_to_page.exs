defmodule FbRanker.Repo.Migrations.AddCatToPage do
  use Ecto.Migration

  def change do
    alter table(:pages) do
      add :category, :string
    end
  end
end
