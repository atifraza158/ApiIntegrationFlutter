// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:api_integration/getModels/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserModelApi extends StatefulWidget {
  const UserModelApi({super.key});

  @override
  State<UserModelApi> createState() => _UserModelApiState();
}

class _UserModelApiState extends State<UserModelApi> {
  List<UsersModel> userList = [];

  Future<List<UsersModel>> getUsersApi() async {
    final responce =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map i in data) {
        userList.add(UsersModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("User Model Api"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsersApi(),
              builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              ReusableRow(
                                  name: "Name: ",
                                  value: snapshot.data![index].name.toString()),
                              ReusableRow(
                                  name: "Email: ",
                                  value:
                                      snapshot.data![index].email.toString()),
                              ReusableRow(
                                  name: "UserName: ",
                                  value: snapshot.data![index].username
                                      .toString()),
                              ReusableRow(
                                  name: "Address: ",
                                  value: snapshot.data![index].address!.city
                                      .toString()),
                              ReusableRow(
                                  name: "Geo: ",
                                  value: snapshot.data![index].address!.geo!.lat
                                      .toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String name;
  final String value;
  ReusableRow({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Text(value),
      ],
    );
  }
}
