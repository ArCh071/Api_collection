import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Route_page extends StatefulWidget {
  Route_page({Key? key, required this.route_id}) : super(key: key);
  String? route_id;
  @override
  State<Route_page> createState() => _Route_pageState();
}

class _Route_pageState extends State<Route_page>{
  List<Map> customer_detail = [];
  Future details() async{
    final Url = "https://testsys.yes45.in/api/get-customer";
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
            height: size.height/50,
          ),
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
                customer_detail.clear();
                snapshot.data["data"].forEach((e){
                  print("${widget.route_id}== ${e["route_id"]}");
                  if(widget.route_id == e["route_id"].toString()){
                    print("object");
                    customer_detail.add({"customer_name": e["name"], "Mobile_number": e["mobile"],"House_name": e["house_name"], "Payment_method": e["payment_method"]});
                    print(customer_detail);

                  }
                });
                return Expanded(
                  child:  ListView.builder(
                      itemCount: customer_detail.length,
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
                                        Text("Customer Name : ${customer_detail[index]["customer_name"]}"),
                                        Text("Mobile Number : ${customer_detail[index]["Mobile_number"].toString()}"),
                                        Text("House Name : ${customer_detail[index]["House_name"]}"),
                                        Text("Payment Method : ${customer_detail[index]["Payment_method"]}"),
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
