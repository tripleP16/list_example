import 'package:list_example/model/doctor.dart';

class DoctorsRepository {
  List<Doctor> doctors  = [
    Doctor(id: '1', image: 'https://www.adslzone.net/app/uploads-adslzone.net/2019/04/borrar-fondo-imagen.jpg', name: 'iliana', lastname: 'dias', specialty: 'Cardiologo'),
    Doctor(id: '2', image: 'ffff', name: 'Pablo', lastname: 'Perez', specialty: 'Medicina Interna'),
    Doctor(id: '3', image: 'ffff', name: 'Franco', lastname: 'dias', specialty: 'Cardiologo'),
    Doctor(id: '4', image: 'ffff', name: 'Lorenzo', lastname: 'Perez', specialty: 'Medicina Interna'),
    Doctor(id: '5', image: 'ffff', name: 'Rodolfo', lastname: 'Perez', specialty: 'Cirugia'),
  ];

  Future<List<Doctor>> sendList() async {
    await Future.delayed(Duration(seconds: 5));
    return doctors;
  }

  Future<List<Doctor>> filterBySpeciality(String input) async {
    await Future.delayed(Duration(seconds: 3));
    return doctors.where((element) => element.specialty.contains(input)).toList();
  }
}