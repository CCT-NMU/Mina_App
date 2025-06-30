class User {
  String? id; // Unique identifier for the user
  String? name;
  String? surname;
  String? email;
  DateTime? birthday;
  int? avgCycleLength; // average length of menstrual cycle
  int? avgPeriodLength; // average length of period
  DateTime? lastestCycleStart;

  User(
      {this.id,
      this.name,
      this.surname,
      this.email,
      this.birthday,
      this.avgCycleLength = 0,
      this.avgPeriodLength = 0,
      this.lastestCycleStart});

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

  void setAvgCycleLength(int cycleLength) {
    avgCycleLength = cycleLength;
  }

  void setAvgPeriodLength(int periodLength) {
    avgPeriodLength = periodLength;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'birthday': birthday,
      'avgCycleLength': avgCycleLength,
      'avgPeriodLength': avgPeriodLength,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      email: map['email'],
      birthday: map['birthday'],
      avgCycleLength: map['cycleLength'],
      avgPeriodLength: map['periodLength'],
    );
  }
}
