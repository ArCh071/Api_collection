import 'package:collection_app/model/clipper.dart';
import 'package:collection_app/view/collection.dart';
import 'package:flutter/material.dart';

class First_page extends StatefulWidget {
  const First_page({Key? key}) : super(key: key);

  @override
  State<First_page> createState() => _First_pageState();
}

class _First_pageState extends State<First_page> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            child: Container(
              height: 300,
              color: Colors.blue[900]?.withOpacity(0.7),
            ),
            clipper: Myclipper(),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Collection App", style: TextStyle(
                color: Colors.grey[500],
                fontSize: 70,
                fontWeight: FontWeight.bold
            ),),
          ),
          SizedBox(
            height: 100,
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Collection(),));
            },
            child: Container(
              height: 50,
              width: 100,
              child: Center(child: Text("Get Started", style: TextStyle(color: Colors.white),)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue[900]?.withOpacity(0.7)
              ),
            ),
          )
        ],
      ),
    );
  }
}
