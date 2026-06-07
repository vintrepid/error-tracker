defmodule ErrorTracker.Migration.Postgres.V06 do
  @moduledoc false

  use Ecto.Migration

  def up(%{prefix: prefix}) do
    environment = ErrorTracker.environment()

    alter table(:error_tracker_errors, prefix: prefix) do
      add :environment, :string, default: environment, null: false
    end

    alter table(:error_tracker_occurrences, prefix: prefix) do
      add :environment, :string, default: environment, null: false
    end

    drop_if_exists unique_index(:error_tracker_errors, [:fingerprint], prefix: prefix)
    create unique_index(:error_tracker_errors, [:environment, :fingerprint], prefix: prefix)
    create index(:error_tracker_errors, [:environment], prefix: prefix)
    create index(:error_tracker_occurrences, [:environment], prefix: prefix)
  end

  def down(%{prefix: prefix}) do
    drop_if_exists index(:error_tracker_occurrences, [:environment], prefix: prefix)
    drop_if_exists index(:error_tracker_errors, [:environment], prefix: prefix)

    drop_if_exists unique_index(:error_tracker_errors, [:environment, :fingerprint],
                     prefix: prefix
                   )

    create unique_index(:error_tracker_errors, [:fingerprint], prefix: prefix)

    alter table(:error_tracker_occurrences, prefix: prefix) do
      remove :environment
    end

    alter table(:error_tracker_errors, prefix: prefix) do
      remove :environment
    end
  end
end
