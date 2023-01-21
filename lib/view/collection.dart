import 'dart:convert';

import 'package:collection_app/model/collection_amount.dart';
import 'package:collection_app/view/collection_post.dart';
import 'package:collection_app/view/customer_route.dart';
import 'package:collection_app/view/registration_form.dart';
import 'package:collection_app/view/schemes.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../model/clipper.dart';

class Collection extends StatefulWidget {
  const Collection({Key? key}) : super(key: key);

  @override
  State<Collection> createState() => _HomeState();
}

class _HomeState extends State<Collection> {
  Future dataget() async{
    final Url = "https://testsys.yes45.in/api/get-customer";
    var response = await get(Uri.parse(Url));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
  }
  Future getplace(String? placeid) async{
    final Url = "https://testsys.yes45.in/api/get-place?route_id=${placeid}";
    var response = await get(Uri.parse(Url));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ClipPath(
              child: Container(
                height: size.height/2.5,
                color: Colors.blue[900]?.withOpacity(0.7),
              ),
              clipper: Myclipper(),
            ),
            ListTile(
              title: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue[900]?.withOpacity(0.7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('Schemes',style: TextStyle(
                        fontSize: 20, color: Colors.white
                    ),),
                  )),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Schemes(),));
              },
            ),
            ListTile(
              title: Material(
                borderRadius: BorderRadius.circular(20),
                  color: Colors.blue[900]?.withOpacity(0.7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('Routes', style: TextStyle(
                      fontSize: 20, color: Colors.white
                    ),),
                  )),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Route_customer(),));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[900]?.withOpacity(0.7),
        leading: Builder(
            builder: (context){
              return IconButton(onPressed: () =>
                  Scaffold.of(context).openDrawer(),
                  icon: Icon(Icons.menu));
            }),
        actions: [
          IconButton(onPressed: ()=>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Reg_form(),)),
              icon: Icon(Icons.person_add_alt)),
          TextButton(onPressed: ()=>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Collection_post(),)),
            child: Column(
              children: [
                Text("Fund", style: TextStyle(color: Colors.white),),
                Text("Collection",style: TextStyle(color: Colors.white))
              ],
            ),),
        ],
      ),
      body: CustomRefreshIndicator(
        builder: MaterialIndicatorDelegate(
          builder: (context, controller) {
            return Icon(
              Icons.refresh_outlined,
              color: Colors.blue[700]?.withOpacity(0.7),
              size: 30,
            );
          },
        ),
        onRefresh: dataget,
        child: Column(
          children: [
            FutureBuilder(
                future: dataget(),
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
                          Amount.amount_collection = snapshot.data["data"][index]["collection_amount"];
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRect(
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue[700]?.withOpacity(0.7),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("id:"),
                                              Text(snapshot.data["data"][index]["id"].toString())
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Name:"),
                                              Text(snapshot.data["data"][index]["name"])
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("mobile number:"),
                                              Text(snapshot.data["data"][index]["mobile"])
                                            ],
                                          ),
                                          //not null above
                                          snapshot.data["data"][index]["gardian_name"]==null?SizedBox.shrink() :Row(
                                            children: [
                                              Text("Gardian Name:"),
                                              Text(snapshot.data["data"][index]["gardian_name"])
                                            ],
                                          ),

                                          snapshot.data["data"][index]["post"]==null?SizedBox.shrink()  :Row(
                                            children: [
                                              Text("Post: ${snapshot.data["data"][index]["post"]}"),
                                            ],
                                          ),
                                          snapshot.data["data"][index]["pin"]==null? SizedBox.shrink() :Row(
                                            children: [
                                              Text("Pin:"),
                                              Text(snapshot.data["data"][index]["pin"])
                                            ],
                                          ),
                                          snapshot.data["data"][index]["land_mark"]==null?SizedBox.shrink() :Row(
                                            children: [
                                              Text("Landmark:"),
                                              Text(snapshot.data["data"][index]["land_mark"])
                                            ],
                                          ),
                                          //not null below
                                          Row(
                                            children: [
                                              Text("Payment:"),
                                              Text(snapshot.data["data"][index]["payment_method"])
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Route id:"),
                                              Text(snapshot.data["data"][index]["route_id"].toString())
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Place : "),
                                              FutureBuilder(
                                                  future: getplace(snapshot.data["data"][index]["place_id"].toString()),
                                                  builder: (context, AsyncSnapshot snapshot) {
                                                    return Text(snapshot.data.toString());
                                                  }
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Place id:"),
                                              Text(snapshot.data["data"][index]["place_id"].toString())
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Text("Scheme id:"),
                                              Text(snapshot.data["data"][index]["scheme_id"].toString()),

                                            ],
                                          ),
                                          Row(mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  showAlertDialog(context);
                                                },
                                                child: Material(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Colors.orange[400],
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text("Collection"),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          );
                        }
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
showAlertDialog(BuildContext context) {
  var alert =AlertDialog(
    backgroundColor: Colors.blue[900],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
    title: Text("Collection Amount", style: TextStyle(
      color: Colors.white
    ),),
    content: Text(Amount.amount_collection, style: TextStyle(
      color: Colors.white
    ),),
    actions: [
  TextButton(
  child: Text("Ok", style: TextStyle(color: Colors.white),),
  onPressed:  () {
  Navigator.of(context).pop();
  },
  ),
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
