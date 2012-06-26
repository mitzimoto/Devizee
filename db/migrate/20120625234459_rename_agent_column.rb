class RenameAgentColumn < ActiveRecord::Migration
  def up
      rename_column :listings, :list_agent, :agent_code
  end

  def down
      rename_column :listings, :agent_code, :list_agent
  end
end
