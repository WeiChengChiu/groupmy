# faker user and his groups and posts
user =  User.create!(
          name: 'test',
          email: 'test@gmail.com',
          password: 12345678,
          password_confirmation: 12345678
        )

Group.populate(5) do |group|
  group.title = Populator.words(3..5),
  group.description = Populator.sentences(1),
  group.user_id = user.id

  GroupUser.create!(group_id: group.id, user_id: user.id)
  Post.populate(5) do |post|
    post.content = Populator.sentences(1),
    post.group_id = group.id,
    post.user_id = user.id
  end
end
