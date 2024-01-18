users = User.create([
  {
    first_name: "Bruno",
    last_name: "Oliveira",
    address: "123 Main Street",
    city: "London",
  },
  {
    first_name: "Nayara",
    last_name: "Lopes",
    address: "24 High Street",
    city: "New York",
  }
])

posts = Post.create!([
  {
    body: "This is a post",
    user: users.first
  },
  {
    body: "This is another post",
    user: users.first
  },
  {
    body: "This is yet another post",
    user: users.last
  }
])

Comment.create!([
  {
    body: "This is a comment",
    post: posts.first,
    user: users.first
  },
  {
    body: "This is another comment",
    post: posts.first,
    user: users.last
  }
])
