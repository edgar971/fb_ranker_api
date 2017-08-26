defmodule FbRanker.Repo.Migrations.CreateGroupPages do
  use Ecto.Migration

  def change do
    create table(:group_pages, primary_key: false) do
      add :group_id, references(:groups)
      add :page_id, references(:pages)
    end
  end
end
