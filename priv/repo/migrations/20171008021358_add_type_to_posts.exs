defmodule FbRanker.Repo.Migrations.AddTypeToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :type, :string
    end
  end
end
