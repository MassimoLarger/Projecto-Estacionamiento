import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'usuario.dart';
import 'sede.dart';
import 'patente_modelo.dart';
import 'verificaciones/eliminar_patente.dart';

class PatentesPage extends StatefulWidget {
  final String userId;

  const PatentesPage({Key? key, required this.userId}) : super(key: key);

  @override
  PatentesPageState createState() => PatentesPageState();
}

class PatentesPageState extends State<PatentesPage> {
  List<String> patentes = [];
  int? selectedPatenteIndex;
  Set<String> markedForDeletion = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPatentes();
  }

  Future<void> _fetchPatentes() async {
    final url = Uri.parse('http://localhost:3500/api/consultar');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'correo': widget.userId}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody['success']) {
          final dynamic patentesData = responseBody['patentes'];

          if (patentesData is List) {
            setState(() {
              patentes = List<String>.from(patentesData); // Convertir a List<String>
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('El campo "patentes" no es una lista válida.')),
            );
          }
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody['message'])),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error en la solicitud. Inténtalo de nuevo.')),
        );
      }
    } catch (e) {
      print('Error fetching patentes: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error en la solicitud. Inténtalo de nuevo.')),
      );
    }
  }

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
              color: Colors.black,
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
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EliminarPatenteWidget(
                        userId: widget.userId,
                        onCompleted: () {
                          setState(() {});
                        },
                      ),
                    ));
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
                      markedForDeletion.remove(patente);
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(''),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return CustomUserDialog(userId: widget.userId);
                },
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                  color: isMarkedForDeletion
                      ? Colors.red
                      : (index == selectedPatenteIndex
                      ? Colors.green
                      : const Color(0xFFC6D4FF)),
                  child: ListTile(
                    title: Text(
                      patente,
                      style: const TextStyle(color: Colors.black),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.black),
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
                        selectedPatenteIndex =
                        index == selectedPatenteIndex ? null : index;
                        if (isMarkedForDeletion) {
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
              onPressed: selectedPatenteIndex != null ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectCampusPage(userId: widget.userId, vehicleid: patentes[selectedPatenteIndex!]),
                  ),
                );
              } : null,
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
                  MaterialPageRoute(
                    builder: (context) => VehicleInfoPage(userId: widget.userId),
                  ),
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