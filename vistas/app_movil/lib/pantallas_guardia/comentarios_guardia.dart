import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminCommentResponsePage extends StatefulWidget {
  const AdminCommentResponsePage({super.key});
  @override
  AdminCommentResponsePageState createState() => AdminCommentResponsePageState();
}

class AdminCommentResponsePageState extends State<AdminCommentResponsePage> {
  final List<Comment> comments = [
    Comment(
      userName: "Usuario de prueba",
      userImage: "assets/images/user.png",
      date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
      comment: "Este es un comentario de prueba",
      responses: [],
    ),
    Comment(
      userName: "Usuario de prueba",
      userImage: "assets/images/user.png",
      date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
      comment: "Este es otro comentario de prueba",
      responses: [],
    ),
  ];
  final Map<int, TextEditingController> responseControllers = {};

  void _sendResponse(int index) {
    setState(() {
      comments[index].responses.add(
        CommentResponse(
          response: responseControllers[index]?.text ?? "",
          date: DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
        ),
      );
      responseControllers[index]?.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,  // Añadido para evitar redimensionamiento automático al abrir el teclado
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Text(
                "Comentarios",
                style: TextStyle(
                  fontFamily: 'Lato', 
                  fontSize: screenWidth * 0.05, 
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),  // Adds whitespace
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                responseControllers[index] ??= TextEditingController();
                return Card(
                  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.035),
                  color: const Color(0xFFF3F8FF),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(comment.userImage),
                        ),
                        title: Text(comment.userName),
                        subtitle: Text(comment.comment),
                        trailing: Text(comment.date),
                      ),
                      ...comment.responses.map((response) => Column(
                            children: [
                              const Divider(),
                              ListTile(
                                leading: const CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/user.png'),
                                ),
                                title: const Text('Administrador'),
                                subtitle: Text(response.response),
                                trailing: Text(response.date),
                              ),
                            ],
                          )),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                        child: TextField(
                          controller: responseControllers[index],
                          cursorColor: Colors.blue, // Color del cursor al escribir
                          decoration: InputDecoration(
                            labelText: "Escribe una respuesta...",
                            labelStyle: const TextStyle(color: Colors.black), // Color for the label
                            fillColor: Colors.white, // Background color of the TextField
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue), // Color of the line when not focused
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue), // Color of the line when focused
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () => _sendResponse(index),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),  // Adds whitespace at the bottom of each card
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Comment {
  final String userName;
  final String userImage;
  final String date;
  final String comment;
  List<CommentResponse> responses;

  Comment({
    required this.userName,
    required this.userImage,
    required this.date,
    required this.comment,
    required this.responses,
  });
}

class CommentResponse {
  String response;
  String date;

  CommentResponse({
    required this.response,
    required this.date,
  });
}
