import 'package:flutter/material.dart';
import 'usuario.dart';
import 'sede.dart';
import 'vehiculos.dart';
//import 'verificaciones/eliminar_patente.dart';

class PatentesPage extends StatefulWidget {
  const PatentesPage({super.key});
  @override
  PatentesPageState createState() => PatentesPageState();
}

class PatentesPageState extends State<PatentesPage> {
  List<String> patentes = ['CJ CH 25', 'CU ML 69', 'CC CM 23'];
  int? selectedPatenteIndex;  // Guarda el índice de la patente seleccionada
  Set<String> markedForDeletion = {};  // Uso de literal de conjunto

  void _removePatente(String patente) {
    double width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "¿Estás seguro que deseas eliminar tu patente?",
            style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      patentes.remove(patente);
                      markedForDeletion.remove(patente);  // Elimina la marca de eliminación
                    });
                    Navigator.of(context). pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 15),
                  ),
                  child: const Text("Sí", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      markedForDeletion.remove(patente);  // Mantiene la patente y elimina la marca de eliminación
                    //EliminarPatenteWidget
                    });
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 15),
                  ),
                  child: const Text("No", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context). pop(),
        ),
        title: const Text(''),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const CustomUserDialog();
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 16.0, bottom: 6.0),
            child: Text(
              'Patentes',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Lato', fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Selecciona la patente que utilizarás hoy:',
              style: TextStyle(fontFamily: 'Lato', fontSize: 16, fontWeight: FontWeight.normal),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: patentes.length,
              itemBuilder: (context, index) {
                String patente = patentes[index];
                bool isMarkedForDeletion = markedForDeletion.contains(patente);
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 0,
                  color: isMarkedForDeletion ? Colors.red : (index == selectedPatenteIndex ? Colors.green : const Color(0xFF567DF4)),
                  child: ListTile(
                    title: Text(
                      patente,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          if (!markedForDeletion.contains(patente)) {
                            markedForDeletion.add(patente);
                          }
                        });
                        _removePatente(patente);
                      },
                    ),
                    onTap: () {
                      setState(() {
                        selectedPatenteIndex = index == selectedPatenteIndex ? null : index;
                        if (isMarkedForDeletion) {  // Si está marcado para eliminación y se toca, se desmarca
                          markedForDeletion.remove(patente);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SelectCampusPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF567DF4),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Continuar', style: TextStyle(fontSize: 18)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MisVehiculosScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF567DF4),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Agregar Patente', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
