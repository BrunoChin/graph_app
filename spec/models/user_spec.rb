require 'rails_helper'

RSpec.describe "mutations user tests" do
  it "create a new user" do

    result = GraphAppSchema.execute(create_string, variables: {
      firstName: "Bruno",
      lastName:"Oliveira"
    })

    expect(result['data']['createUser']).to include(
      'id' => anything,
      'firstName' => "Bruno",
      'lastName' => "Oliveira"
    )

  end

  it "update user" do

    user = FactoryBot.create(:user)

    result = GraphAppSchema.execute(update_string, variables: {
      id: 1,
      firstName: "Nayara",
      lastName: "Oliveira"
    })

    expect(result['data']['updateUser']).to include(
      'firstName' => "Nayara",
      'lastName' => "Oliveira"
    )
  end


  it "First name shorter than 3 characters" do
    result = GraphAppSchema.execute(create_string, variables: {
      firstName: "Br",
      lastName:"Oliveira"
    })

    expect(result['errors'].first['message']).to eq("O primeiro nome deve ter no mínimo 3 caracteres")
  end

  it "Last name shorter than 3 characters" do
    result = GraphAppSchema.execute(create_string, variables: {
      firstName: "Bruno",
      lastName:"Ol"
    })

    expect(result['errors'].first['message']).to eq("O sobrenome deve ter no mínimo 3 caracteres")
  end

  it "delete user" do

    user = FactoryBot.create(:user)

    result = GraphAppSchema.execute(
      <<~GQL
        mutation delete{
          deleteUser(id: 1)
        }
      GQL
    )

    expect(result['data']['deleteUser']).to eq(true)

  end

  def create_string
    <<~GQL
      mutation Create($firstName: String!, $lastName: String!){
        createUser(firstName: $firstName, lastName: $lastName){
          id
          firstName
          lastName
        }
      }
    GQL
  end

  def update_string
    <<~GQL
      mutation Update($id: ID!, $firstName: String!, $lastName: String!){
        updateUser(id: $id, firstName: $firstName, lastName: $lastName){
          id
          firstName
          lastName
        }
      }
    GQL
  end
end
