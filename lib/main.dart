import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'database_helper.dart';

void main() {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const SqfliteApp());
}

class SqfliteApp extends StatefulWidget {
  const SqfliteApp({super.key});

  @override
  State<SqfliteApp> createState() => _SqfliteAppState();
}

class _SqfliteAppState extends State<SqfliteApp> {
  int _currentIndex = 0;

  String dato0 = "";
  String dato1 = "";
  String dato2 = "";
  String dato3 = "";
  String dato4 = "";
  String dato5 = "";

  List<Map<String, dynamic>> retrievedData = [];

  final TextEditingController _dato0Controller = TextEditingController();
  final TextEditingController _dato1Controller = TextEditingController();
  final TextEditingController _dato2Controller = TextEditingController();
  final TextEditingController _dato3Controller = TextEditingController();
  final TextEditingController _dato4Controller = TextEditingController();
  final TextEditingController _dato5Controller = TextEditingController();

  //get myDb => DatabaseHelper();

  void newRecord() {
    dato0 = "";
    dato1 = "";
    dato2 = "";
    dato3 = "";
    dato4 = "";
    dato5 = "";

    _dato0Controller.text = "";
    _dato1Controller.text = "";
    _dato2Controller.text = "";
    _dato3Controller.text = "";
    _dato4Controller.text = "";
    _dato5Controller.text = "";
    setState(() {});
  }

  void _handleIconTap() {
    // Gestisci l'azione desiderata quando l'icona viene toccata.
    print('Icona toccata!');
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;

      // Esegui azioni diverse in base all'elemento selezionato
      switch (index) {
        case 0:
          // Azione per l'elemento "Home"
          _addToDatabase();
          newRecord();
          break;
        case 1:
          // Azione per l'elemento "Search"
          _retrieveFromDatabase();
          break;
        case 2:
          // Azione per l'elemento "Search"

          break;
        case 3:
          // Azione per l'elemento "Search"
          _delAllFromDatabase();
          break;
        case 4:
          // Azione per l'elemento "Profile"
          exit(0);
      }
    });
  }

  Future<void> _addToDatabase() async {
    await DatabaseHelper().insertData({
      'dato0': dato0,
      'dato1': dato1,
      'dato2': dato2,
      'dato3': dato3,
      'dato4': dato4,
      'dato5': dato5,
    });
  }

  Future<void> _retrieveFromDatabase() async {
    List<Map<String, dynamic>> data = (await DatabaseHelper().getData());
    // Fai qualcosa con i dati recuperati, ad esempio aggiornare lo stato del widget
    int last = data.length;

    _dato0Controller.text = dato0;
    _dato1Controller.text = dato1;
    _dato2Controller.text = dato2;
    _dato3Controller.text = dato3;
    _dato4Controller.text = dato4;
    _dato5Controller.text = dato5;
    retrievedData = data;
    setState(() {});
  }

  Future<void> _delAllFromDatabase() async {
    final Database db = await DatabaseHelper().database;
    await db.delete('my_table');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 89, 169, 243),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined, color: Colors.blue),
              label: 'add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.recent_actors_outlined, color: Colors.green),
              label: 'retrive',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.recent_actors_outlined, color: Colors.orange),
              label: 'modify',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.recent_actors_outlined, color: Colors.redAccent),
              label: 'delete',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app, color: Colors.black),
              label: 'exit',
            ),
          ],
        ),
        appBar: AppBar(
          title: const Text('SqfliteApp'),
        ),
        body: SingleChildScrollView(
          // Wrap con SingleChildScrollView
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Text(dato0),
                        TextField(
                          controller: _dato0Controller,
                          onChanged: (value) {
                            dato0 = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Text(dato1),
                        TextField(
                          controller: _dato1Controller,
                          onChanged: (value) {
                            dato1 = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Text(dato2),
                        TextField(
                          controller: _dato2Controller,
                          onChanged: (value) {
                            dato2 = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                // Divider per la linea orizzontale
                color: Colors.red, // Colore della linea
                thickness: 2.0, // Spessore della linea
              ),
              Row(
                children: [
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Text(dato3),
                        TextField(
                          controller: _dato3Controller,
                          onChanged: (value) {
                            dato3 = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Text(dato4),
                        TextField(
                          controller: _dato4Controller,
                          decoration: InputDecoration(
                            labelText: 'nome',
                            icon: GestureDetector(
                              onTap: _handleIconTap,
                              child: const Icon(
                                Icons.airport_shuttle_outlined,
                                color: Color.fromARGB(255, 248, 64, 8),
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                          onChanged: (value) {
                            dato4 = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Text(dato5),
                        TextField(
                          controller: _dato5Controller,
                          onChanged: (value) {
                            dato5 = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                // Divider per la linea orizzontale
                color: Colors.red, // Colore della linea
                thickness: 2.0, // Spessore della linea
              ),
              Row(
                children: [
                  const SizedBox(width: 20),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('lista',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              letterSpacing: 4,
                            )),
                        SizedBox(
                          height: 200,
                          width: 200,
                          // Specifica un'altezza per il ListView
                          child: ListView.builder(
                            itemCount: retrievedData.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _dato0Controller.text =
                                      retrievedData[index]['dato0'];
                                  _dato1Controller.text =
                                      retrievedData[index]['dato1'];
                                  _dato2Controller.text =
                                      retrievedData[index]['dato2'];
                                  _dato3Controller.text =
                                      retrievedData[index]['dato3'];
                                  _dato4Controller.text =
                                      retrievedData[index]['dato4'];
                                  _dato5Controller.text =
                                      retrievedData[index]['dato5'];
                                  dato0 = retrievedData[index]['dato0'];
                                  dato1 = retrievedData[index]['dato1'];
                                  dato2 = retrievedData[index]['dato2'];
                                  dato3 = retrievedData[index]['dato3'];
                                  dato4 = retrievedData[index]['dato4'];
                                  dato5 = retrievedData[index]['dato5'];
                                  print('click su $dato1');
                                  setState(() {});
                                },
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    // Aggiungi un Row per le due colonne
                                    children: [
                                      Expanded(
                                        child:
                                            Text(retrievedData[index]['dato0']),
                                      ),
                                      Expanded(
                                        child:
                                            Text(retrievedData[index]['dato1']),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await _retrieveFromDatabase();
          },
          child: const Icon(Icons.agriculture),
        ),
      ),
    );
  }
}
