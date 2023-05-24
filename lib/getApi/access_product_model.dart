import 'dart:convert';

import 'package:api_integration/getModels/products_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsModelAccess extends StatefulWidget {
  const ProductsModelAccess({super.key});

  @override
  State<ProductsModelAccess> createState() => _ProductsModelAccessState();
}

class _ProductsModelAccessState extends State<ProductsModelAccess> {


  // Future Function to get Products images
  Future<ProductsModel> getProductsApi() async {
    final responce = await http.get(Uri.parse("https://webhook.site/51629ce8-f160-4a16-ac17-56a47af39360"));
    var data = jsonDecode(responce.body.toString());
    if(responce.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Products", style: TextStyle(color: Colors.black,fontSize: 21)),
            Icon(Icons.shopify_sharp,color: Colors.black, size: 30,)
          ],
        )),
        body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductsModel>(
                future: getProductsApi(),
                builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                          ),
                          title: Text(snapshot.data!.data![index].shop!.name.toString()),
                          subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .25,
                          width: MediaQuery.of(context).size.width * 1,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.data![index].images!.length,
                            itemBuilder: (context, position) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                              height: MediaQuery.of(context).size.height * .25,
                              width: MediaQuery.of(context).size.width * .7,
                              decoration: BoxDecoration(   
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                  snapshot.data!.data![index].images![position].url.toString(),
                                ),
                                ),
                              ),
                              )
                            );
                          },),
                        ),
                        
                      ],
                    );
                  },);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },),
            ),
          ],
        ),
      ),
    );
  }
}