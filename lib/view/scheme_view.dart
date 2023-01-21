import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Scheme extends StatefulWidget {
   Scheme({Key? key, required this.ids}) : super(key: key);
String? ids;
  @override
  State<Scheme> createState() => _SchemeState();
}

class _SchemeState extends State<Scheme> {
  List<Map> customer_details = [];
  Future details() async{
    final Url = "https://testsys.yes45.in/api/get-customer";
    var response = await get(Uri.parse(Url));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
  }
  @override
  Widget build(BuildContext context) {
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
          FutureBuilder(
            future: details(),
            builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              if(!snapshot.hasData){
                return Center(child: Text("no data", style: TextStyle(
                  color: Colors.blue
                ),));
              }
              customer_details.clear();
             snapshot.data["data"].forEach((e){
               print(e["scheme_id"]);
              if(widget.ids == e["scheme_id"].toString()){
                customer_details.add({"customer_name": e["name"], "Mobile_number": e["mobile"],"House_name": e["house_name"], "Payment_method": e["payment_method"]});
              }
              });
              return Expanded(
                    child:  ListView.builder(
                        itemCount: customer_details.length,
                        itemBuilder: (context, index) {
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
                                        Text("Customer Name : ${customer_details[index]["customer_name"]}"),
                                          Text("Mobile Number : ${customer_details[index]["Mobile_number"]}"),
                                          Text("House Name : ${customer_details[index]["House_name"]}"),
                                          Text("Payment Method : ${customer_details[index]["Payment_method"]}"),
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
          )
        ],
      ),
    );
  }
}
