import 'package:flutter/material.dart';
import 'package:list_example/model/doctor.dart';
import 'package:list_example/state/doctors_state.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List<int> colorCodes = <int>[600, 500, 100];
  bool _isLoading = false;
  List<Doctor> entries = [];
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<DoctorState>(context, listen: false).fetchDoctors().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();

  }
  void filterDoctors(String value) {
    Provider.of<DoctorState>(context, listen: false).filterDoctors(value);
  }
  void filterDoctorBySpeciality(String value) async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<DoctorState>(context, listen: false).filterDoctorBySpeciality(value);
    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    entries = Provider.of<DoctorState>(context).doctorsToShow;
    return Scaffold(
        appBar: AppBar(
          title: Text('Busqueda de doctores'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                child: Text('Seleccione especialidad'),
              ),
              ListTile(
                title: const Text('Todos'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  filterDoctorBySpeciality('');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Cardiologos'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  filterDoctorBySpeciality('Cardiologo');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
            child:  _isLoading ? const CircularProgressIndicator() : Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                onChanged: (value){
                  filterDoctors(value);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    hintText: 'Buscar',
                    icon: Icon(Icons.person_search)),
              ),
              const Divider(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Card(
                                child:  InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  debugPrint('Card tapped.');
                                },
                                child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: SizedBox(
                                              width: 300,
                                              height: 100,
                                              child: Row(
                                                children: <Widget>[
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(75.0),
                                                    child: CircleAvatar(
                                                    backgroundColor: Colors.amber,
                                                    radius: 50,
                                                    child: Image.network(
                                                      entries[index].image,
                                                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                        return CircleAvatar(
                                                            backgroundColor: Colors.amber,
                                                            radius: 50,
                                                        );
                                                      } ,
                                                      height: 150.0,
                                                      width: 150.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Text(entries[index].name),
                                                      const Divider(
                                                        height: 20,
                                                      ),
                                                      Text(entries[index].lastname)
                                                    ],
                                                  )

                                                ],
                                              ),
                                          ),
                                )
                              ),
                        )
                    );
                  },
                ),
              )
            ],
          ),
        )
    );
  }
}
