import 'dart:convert';

import 'package:collection_app/view/route_percustomer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Route_customer extends StatefulWidget {
  const Route_customer({Key? key}) : super(key: key);

  @override
  State<Route_customer> createState() => _Route_customerState();
}

class _Route_customerState extends State<Route_customer> {
  Future route() async{
    final Url = "https://testsys.yes45.in/api/get-route";
    var response = await get(Uri.parse(Url));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Routes", style: TextStyle(
            fontSize: 22
        ),),
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.black,)),
        backgroundColor: Colors.blue[900]?.withOpacity(0.7),
        elevation: 0,
      ),

      body: Column(
        children: [
          SizedBox(
            height: size.height/30,
          ),
          FutureBuilder(
            future: route(),
            builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              if(!snapshot.hasData){
                print("snapshot data is ${snapshot.data}");
                return Text("no data");
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data["data"].length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: (){
                            print("Id : ${snapshot.data["data"][index]["id"]}");
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Route_page(route_id: snapshot.data["data"][index]["id"].toString(),),));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: size.height/13,
                                width: size.width/1.2,
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Id : ${snapshot.data["data"][index]["id"]}", style: TextStyle(
                                        fontSize: 16
                                    ),),
                                    Text(snapshot.data["data"][index]["route_name"], style: TextStyle(
                                      fontSize: 16
                                    ),),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue[700]?.withOpacity(0.7)
                                ),),
                          ),
                        ),
                      ],
                    );
                  }
                ),
              );
            }
          )
        ],
      ),
    );
  }

}
