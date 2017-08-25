defmodule FbRanker.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      add :description, :string, size: 255

      timestamps()
    end

  end
end
