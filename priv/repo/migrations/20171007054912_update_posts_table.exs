defmodule FbRanker.Repo.Migrations.UpdatePostsTable do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :comments, :integer
      modify :message, :string, size: 1000
      modify :story, :string, size: 1000
    end
  end
end
