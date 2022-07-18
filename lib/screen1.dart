import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lab3/screen2.dart';

//presentation layer
class ArticlesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticleListState();
  }
}

class _ArticleListState extends State<ArticlesList> {
  late Future<List<Article>> article;

  @override
  void initState() {
    super.initState();
    article = RemoteDataSource().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: article,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var _articles = (snapshot.data as List<Article>);
              //handle data response
              // return UserListItem(_user);
              return ListView.builder(
                  itemCount: _articles.length,
                  itemBuilder: (context, index) =>
                      ArticleListItem(_articles[index]));
            } else if (snapshot.hasError) {
              //handle error response
              return Container(
                child: Center(child: Text('has error')),
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ArticleListItem extends StatelessWidget {
  var _article;

  ArticleListItem(this._article);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        child: Center(
            child: InkWell(
          child: Card(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Image.network(
                    _article.picture,
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
                      Text(_article.title),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailes(artDetails: _article),
              ),
            );
          },
        )),
      ),
    );
  }
}

//data layer
class Article {
  String title;
  String picture;
  String content;
  String id;

  Article(
    this.title,
    this.picture,
    this.content,
    this.id,
  );

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      json['title'],
      json['picture'],
      json['content'],
      json['id'],
    );
  }
}

//Data layer
class RemoteDataSource {
  Future<List<Article>> fetchUsers() async {
    var response = await http.get(
        Uri.parse('https://62d4154fcd960e45d452f790.mockapi.io/api/article'));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      var list = (jsonResponse as List);
      var newList = list.map((item) => Article.fromJson(item)).toList();
      return newList;
    } else {
      throw Exception('Can not fetch user');
    }
  }
}
