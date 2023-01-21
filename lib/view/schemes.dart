import 'dart:convert';

import 'package:collection_app/view/scheme_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Schemes extends StatefulWidget {
  const Schemes({Key? key}) : super(key: key);

  @override
  State<Schemes> createState() => _SchemesState();
}

class _SchemesState extends State<Schemes> {
  String? scheme_id ;
  Future getdata() async{
    final Url = "https://testsys.yes45.in/api/get-scheme";
    var response = await get(Uri.parse(Url));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    print("the response is ${response.body}");
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.black,)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
         SizedBox(
           height: size.height/30,
         ),
          FutureBuilder(
              future: getdata(),
              builder: (context, AsyncSnapshot snapshot) {
                print("object");
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
                        return  InkWell(
                          onTap: (){
                            print("scheme id is ${scheme_id}");
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Scheme(ids: snapshot.data["data"][index]["id"].toString(),),));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: size.height/6,
                                child: Material(
                                  color: Colors.blue[900]?.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Scheme : ${snapshot.data["data"][index]["name"]}", style: TextStyle(
                                            fontSize: 20
                                        ),),
                                        Text("Code : ${snapshot.data["data"][index]["code"]}",style: TextStyle(
                                            fontSize: 20
                                        ),),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        );
                      }
                  ),
                );
              }
          ),
        ],
      ),
    );
  }
}
