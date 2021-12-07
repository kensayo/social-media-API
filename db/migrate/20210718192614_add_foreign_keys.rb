# frozen_string_literal: true

class AddForeignKeys < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :comments, :users
    add_foreign_key :likes, :posts
    add_foreign_key :likes, :users
  end
end
