defmodule FbRanker.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :message, :string
      add :story, :string
      add :created_time, :string
      add :fb_id, :string
      add :shares, :integer
      add :likes, :integer
      add :page_id, :string
      timestamps()
    end

  end
end
