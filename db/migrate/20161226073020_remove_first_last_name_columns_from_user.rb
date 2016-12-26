class RemoveFirstLastNameColumnsFromUser < ActiveRecord::Migration
  def up
    add_column :users, :name, :string

    User.all.each do |u|
      u.update! name: "#{u.first_name} #{u.last_name}"
    end

    remove_column :users, :first_name
    remove_column :users, :last_name
  end

  def down
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string

    User.all.each do |u|
      n = u.name
      u.update! last_name: n.slice!(/\w+\z/)
      u.update! first_name: n.strip
    end

    remove_column :users, :name, :string
  end
end
