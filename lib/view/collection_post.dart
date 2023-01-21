import 'package:collection_app/view/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Collection_post extends StatefulWidget {
  const Collection_post({Key? key}) : super(key: key);

  @override
  State<Collection_post> createState() => _Collection_postState();
}

class _Collection_postState extends State<Collection_post> {
  Future postdata() async {
    var response = await http.post(Uri.parse("https://testsys.yes45.in/api/create-collection"),
        body:{"customer_id": customer_id.text,
          "amount": amount.text,
          "payment_method": selected,
          "route_id":route_id.text,
          "place_id": place_id.text,
          "scheme_id":scheme_id.text,
        });
    print(response.body);
  }
  String? selected = "-select-";
  List payment = ["-select-","CASH", "UPI"];
  TextEditingController customer_id = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController route_id = TextEditingController();
  TextEditingController place_id = TextEditingController();
  TextEditingController scheme_id = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height/20,),
              Row(
                children: [
                  SizedBox(
                    width: size.width/40,
                  ),
                  Text(
                    "Collection Form",
                    style: TextStyle(
                        fontSize: 35, color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: size.height/35,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*";
                    }
                  },
                  controller: customer_id,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.orange)),
                      hoverColor: Colors.orange,
                      labelText: "Customer id",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*";
                    }
                  },
                  controller: amount,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.orange)),
                      hoverColor: Colors.orange,
                      labelText: "Amount",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              //payment method here...............
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                    validator: (value) {
                      if(value == payment[0]){
                        return "*";
                      }
                    },
                    dropdownColor: Colors.black,
                    style: TextStyle(color: Colors.white70),decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[900],
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange)),
                    hoverColor: Colors.orange,
                    labelText: "Payment method",
                    labelStyle: TextStyle(color: Colors.orange),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                    items: payment
                        .map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selected = val as String? ;
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*";
                    }
                  },
                  controller: route_id,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.orange)),
                      hoverColor: Colors.orange,
                      labelText: "Route id",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*";
                    }
                  },
                  controller: place_id,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.orange)),
                      hoverColor: Colors.orange,
                      labelText: "Place id",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*";
                    }
                  },
                  controller: scheme_id,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.orange)),
                      hoverColor: Colors.orange,
                      labelText: "scheme id",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: size.height/35,
              ),
              InkWell(
                onTap: () {
                  if (key.currentState!.validate()) {
                    postdata();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Collection()
                        ));
                    final snackBar = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Collection added successfully"),
                        duration: Duration(seconds: 1));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackBar);
                  }
                },
                child: Container(
                  height: size.height/14,
                  width: size.width/3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange),
                  child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

