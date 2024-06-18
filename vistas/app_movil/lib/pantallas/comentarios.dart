import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});
  @override
  CommentPageState createState() => CommentPageState();
}

class CommentPageState extends State<CommentPage> {
  final List<Comment> comments = [];
  final TextEditingController commentController = TextEditingController();

  void addComment(String text) {
    setState(() {
      comments.insert(0, Comment(
        userName: "Nombre del Usuario",
        userImage: "assets/images/user.png",
        date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
        comment: text,
      ));
      commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final Size screenSize = MediaQuery.of(context).size;
    final double padding = screenSize.width * 0.05; // padding basado en el 5% del ancho de la pantalla

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center( 
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: const Text(
                  'Ayuda y Comentarios',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Escribe una sugerencia o reclamo',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: TextField(
                controller: commentController,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF567DF4), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFF567DF4), width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF567DF4)),
                    onPressed: () => addComment(commentController.text),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // prevent scroll within another scrollable widget
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(comment.userImage),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comment.userName),
                          const SizedBox(height: 4),
                          Text(comment.date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      subtitle: Text(comment.comment),
                    ),
                    const Divider(), // Always show a divider after each comment
                  ],
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

  Comment({
    required this.userName,
    required this.userImage,
    required this.date,
    required this.comment,
  });
}
