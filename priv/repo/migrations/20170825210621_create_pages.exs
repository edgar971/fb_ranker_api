defmodule FbRanker.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :name, :string, size: 100
      add :about, :string, size: 255
      add :page_id, :string, size: 100
      add :fan_count, :integer

      timestamps()
    end

  end
end
