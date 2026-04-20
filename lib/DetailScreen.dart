import 'package:app/worldStates.dart';
import 'package:flutter/material.dart';

class Detailscreen extends StatefulWidget {
  String name;
  String image;
  int totalcase,totaldeath,totalrecovered,active,critical,test;
   Detailscreen({super.key,
   required this.name,
   required this.active,
   required this.critical,
   required this.image,
   required this.test,
   required this.totalcase,
   required this.totaldeath,
   required this.totalrecovered
   
   
   
   
   });

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name),centerTitle: true,),
      body: Column(
        children: [
          Stack(
            alignment: AlignmentGeometry.topCenter,
            children: [
              Padding(
                padding:EdgeInsetsGeometry.only(top: MediaQuery.of(context).size.height *.070),
                child: Card(
                  child: Column(
                    children: [
                      CircleAvatar(radius: 80,
                      
                      backgroundImage: NetworkImage(widget.image),),
                      ReusableRow(title: "Cases", value: widget.totalcase.toString()),
                      ReusableRow(title: "Active", value: widget.active.toString()),
                      ReusableRow(title: "Critical", value: widget.critical.toString()),
                      ReusableRow(title: "Test", value: widget.test.toString()),
                      ReusableRow(title: "Total Cases", value: widget.totalcase.toString()),
                      ReusableRow(title: "Total Death", value: widget.totaldeath.toString()),
                      ReusableRow(title: "Total Recovered", value:widget.totalrecovered.toString()),
                     
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
      
    );
  }
}