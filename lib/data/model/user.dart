class User {
  String? id; // Unique identifier for the user
  String? name;
  String? surname;
  String? email;
  DateTime? birthday;
  int? avgCycleLength; // average length of menstrual cycle
  int? avgPeriodLength; // average length of period
  DateTime? lastestCycleStart;

  User({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.birthday,
  });

  void updateProfile({String? name, String? email, int? age}) {
    if (name != null) {
      this.name = name;
    }
    if (email != null) {
      this.email = email;
    }
    if (birthday != null) {
      this.birthday = birthday;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'birthday': birthday,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      email: map['email'],
      birthday: map['birthday'],
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? surname,
    String? email,
    DateTime? birthday,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
    );
  }
}
