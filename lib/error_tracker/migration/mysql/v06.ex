defmodule ErrorTracker.Migration.MySQL.V06 do
  @moduledoc false

  use Ecto.Migration

  def up(_opts) do
    environment = ErrorTracker.environment()

    alter table(:error_tracker_errors) do
      add :environment, :string, default: environment, null: false
    end

    alter table(:error_tracker_occurrences) do
      add :environment, :string, default: environment, null: false
    end

    drop_if_exists unique_index(:error_tracker_errors, [:fingerprint])
    create unique_index(:error_tracker_errors, [:environment, :fingerprint])
    create index(:error_tracker_errors, [:environment])
    create index(:error_tracker_occurrences, [:environment])
  end

  def down(_opts) do
    drop_if_exists index(:error_tracker_occurrences, [:environment])
    drop_if_exists index(:error_tracker_errors, [:environment])
    drop_if_exists unique_index(:error_tracker_errors, [:environment, :fingerprint])
    create unique_index(:error_tracker_errors, [:fingerprint])

    alter table(:error_tracker_occurrences) do
      remove :environment
    end

    alter table(:error_tracker_errors) do
      remove :environment
    end
  end
end
