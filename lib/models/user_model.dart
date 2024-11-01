class user_model {
  String name, image, id, pass, email;

  user_model(
      {required this.name, required this.id, required this.image, required this.email, required this.pass});

  user_model.from_json(map) : this(
      id: map ['id'],
      name: map ['name'],
      email: map ['email'],
      image: map['image'],
      pass: map ['pass']
  );

  to_json() {
    return {
      'id': id,
      'name': name,
      'pass': pass,
      'image': image,
      'email': email
    };
  }
}
