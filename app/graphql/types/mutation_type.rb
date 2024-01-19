# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject

    #user
    field :create_user, UserType, null: false do
      argument :first_name, String, required: true, validates: {length: {minimum: 3, message: "O primeiro nome deve ter no mínimo 3 caracteres"}}
      argument :last_name, String, required: true, validates: {length: {minimum: 3, message: "O sobrenome deve ter no mínimo 3 caracteres"}}
    end
    def create_user(**args)
      user = User.new(args)
      if user.save
        user
      else
        raise GraphQL::ExecutionError.new("Não foi possivel criar ususario.")
      end
    end

    field :update_user, UserType, null: false do
      argument :id, ID, required: true
      argument :first_name, String, required: false, validates: {length: {minimum: 3, message: "O primeiro nome deve ter no mínimo 3 caracteres"}}
      argument :last_name, String, required: false, validates: {length: {minimum: 3, message: "O sobrenome deve ter no mínimo 3 caracteres"}}
      argument :address, String, required: false
      argument :city, String, required: false
    end
    def update_user(id:, **args)

      user = User.find(id)

      if user.update(args)
        user
      else
        raise GraphQL::ExecutionError.new("Não foi possivel atualizar os dados do ususario.")
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
    #end user

    #post
    field :create_post, PostType, null: false do
      argument :body, String, required: true, validates: {length: {minimum: 10}}
      argument :user_id, Integer, required: true
    end
    def create_post(**args)
      Post.create!(args)
    end

    field :update_post, PostType, null: false do
      argument :id, ID, required: true
      argument :body, String, required: true, validates: {length: {minimum: 10}}
    end
    def update_post(id:, body:)
      post = Post.find(id)
      if post.update(body: body)
        post
      else
        raise GraphQL::ExecutationError.new("Não foi possivel atualizar o post")
      end
    end

    field :delete_post, Boolean, null: false do
      argument :id, ID, required: true
    end
    def delete_post(id:)
      post = Post.find(id)

      if post.destroy
        true
      else
        false
      end
    end

    #end post

    #Comment
    field :create_comment, CommentType, null: false do
      argument :body, String, required: true
      argument :user_id, Integer, required: true
      argument :post_id, Integer, required: true
    end
    def create_comment(**args)
      Comment.create!(args)
    end

    field :delete_comment, Boolean, null: false do
      argument :id, ID, required: true
    end
    def delete_comment(id:)
      comment = Comment.find(id)
      if comment.destroy
        true
      else
        false
      end
    end
    #end comment
  end
end
