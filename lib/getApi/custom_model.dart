import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomModel extends StatefulWidget {
  const CustomModel({super.key});

  @override
  State<CustomModel> createState() => _CustomModelState();
}

class _CustomModelState extends State<CustomModel> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
    final responce = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(responce.body.toString());

    if (responce.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Custom Model"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: photosList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data![index].url),
                            ),
                            subtitle: Text(snapshot.data![index].title),
                            title: Text(
                                "Node id: ${snapshot.data![index].id.toString()}"),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class Photos {
  String title;
  String url;
  int id;

  Photos({required this.title, required this.url, required this.id});
}
