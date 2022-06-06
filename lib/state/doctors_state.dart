import 'package:flutter/material.dart';
import 'package:list_example/model/doctor.dart';
import 'package:list_example/requests/doctors_repository.dart';

class DoctorState with ChangeNotifier {
  List<Doctor> doctors = [];
  List<Doctor> doctorsToShow = [];

  Future<void> fetchDoctors() async {
    doctors = await DoctorsRepository().sendList();
    doctorsToShow = doctors;
    notifyListeners();
  }
  void filterDoctors(String input) {
    doctorsToShow = doctors.where((element) => element.name.toLowerCase().contains(input.toLowerCase())).toList();
    notifyListeners();
  }
  Future<void> filterDoctorBySpeciality(String speciality) async {
    doctorsToShow = await DoctorsRepository().filterBySpeciality(speciality);
    notifyListeners();
  }
}