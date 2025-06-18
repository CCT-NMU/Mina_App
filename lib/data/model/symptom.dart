class AppSymptom {
  String name;
  bool? isActive;

  AppSymptom.Symptom({required this.name, this.isActive});

  setActive(bool isActive) {
    this.isActive = isActive;
  }

  getActive() {
    return isActive;
  }

  String getName() {
    return name;
  }
}
