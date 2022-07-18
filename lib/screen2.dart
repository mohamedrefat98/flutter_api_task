import 'package:flutter/material.dart';
import 'screen1.dart';

class ArticleDetailes extends StatelessWidget {
  const ArticleDetailes({super.key, required this.artDetails});
  final Article artDetails;
  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(artDetails.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Card(
              child: Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(left: 25.0, right: 25.0, top: 20),
                    child: Image.network(
                      artDetails.picture,
                      fit: BoxFit.cover,
                      height: 85.0,
                      width: 85.0,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(artDetails.content),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
