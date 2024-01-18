# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject


    field :create_user, UserType, null: false do
      argument :first_name, String, required: true
      argument :last_name, String, required: true
    end
    def create_user(first_name:, last_name:)
      User.create!(first_name: first_name, last_name: last_name)
    end

    field :update_user, UserType, null: false do
      argument :id, ID, required: true
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :address, String, required: false
      argument :city, String, required: false
    end
    def update_user(id:, **args)

      user = User.find(id)

      if user.update(args)
        user
      else
        { success: false }
      end
    end

    field :delete_user, Boolean, null: false do
      argument :id, ID, required: true
    end
    def delete_user(id:)
      user = User.find(id)

      if user.destroy
        true
      else
        false
      end
    end

  end
end
