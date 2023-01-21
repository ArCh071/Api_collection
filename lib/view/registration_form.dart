
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Reg_form extends StatefulWidget {
  const Reg_form({Key? key}) : super(key: key);

  @override
  State<Reg_form> createState() => _Reg_formState();
}

class _Reg_formState extends State<Reg_form> {
  List<Map> routes=[];
  var select_id ;
  String? select = '';
  getroute() async{
    final Url = "https://testsys.yes45.in/api/get-route";
    var response = await get(Uri.parse(Url));
    if(response.statusCode == 200){
      var data =  jsonDecode(response.body);

      data["data"].forEach((e){
        setState(() {
          routes.add({"id":e["id"],"name":e["route_name"]});
        });
      });

      print(routes);
    }
  }
@override
  void initState() {
    // TODO: implement initState
  getroute();
    super.initState();
  }
  Future postdata() async {
    var response = await http.post(Uri.parse("https://testsys.yes45.in/api/create-customer"),
        body:{"name": name.text,
          "mobile": mobile_no.text,
          "gardian_name": guardian_name.text,
          "house_name": house_name.text,
          "post": post.text,
          "pin":pin.text,
          "land_mark": landmark.text,
          "payment_method": selected,
          "route_id":select_id.toString(),
          "place_id": place_id.text,
          "scheme_id":scheme_id.text,
        });
    print(response.body);
  }
  String? selected = "-select-";
  List payment = ["-select-","CASH", "UPI"];
  TextEditingController name = TextEditingController();
  TextEditingController mobile_no = TextEditingController();
  TextEditingController guardian_name = TextEditingController();
  TextEditingController house_name = TextEditingController();
  TextEditingController post = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController landmark = TextEditingController();
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
              SizedBox(height: size.height/35,),
              Row(
                children: [
                  SizedBox(
                    width: size.width/35,
                  ),
                  Text(
                    "Registration Form",
                    style: TextStyle(
                        fontSize: 35, color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: size.height/70,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*";
                    }
                  },
                  controller: name,
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
                      labelText: "Name",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
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
                  controller: mobile_no,
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
                      labelText: "Mobile number",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  controller: guardian_name,
                  decoration: InputDecoration(filled: true,
                      fillColor: Colors.grey[900],
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.orange)),
                      hoverColor: Colors.orange,
                      labelText: "Guardian name",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  minLines: 1,
                  maxLines: 10,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  controller: house_name,
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
                      labelText: "House name",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  controller: post,
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
                      labelText: "Post",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: pin,
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
                      labelText: "Pin",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  minLines: 1,
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  controller: landmark,
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
                      labelText: "Landmark",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
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
                child: DropdownButtonFormField<Map>(
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
                    labelText: "Route",
                    labelStyle: TextStyle(color: Colors.orange),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                    // value: selectedRoutes,
                    items: routes
                        .map((e) => DropdownMenuItem(
                      child: Text(e["name"]),
                      value: e,
                    ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        select = val!["name"] ;
                        select_id = val!["id"];
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
                      labelText: "Scheme id",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              InkWell(
                onTap: () {
                  if (key.currentState!.validate()) {
                    postdata();
                    Navigator.of(context).pop();
                    final snackBar = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Customer Registered Successfully"),
                        duration: Duration(seconds: 1));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackBar);
                  }
                },
                child: Container(
                  height: size.height/15,
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
              SizedBox(
                height: size.height/35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
