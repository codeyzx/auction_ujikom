class Users {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  String? about;
  String? role;

  Users({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.about,
    this.role,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      about: json['about'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'about': about,
      'role': role,
    };
  }

  Users copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    String? about,
    String? role,
  }) {
    return Users(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      about: about ?? this.about,
      role: role ?? this.role,
    );
  }
}
