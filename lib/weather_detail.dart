import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'weather.dart';
import 'package:http/http.dart 'as http;





class nextpage extends StatefulWidget {
  const nextpage({super.key, required this.title});

  final String title;
  @override
  State<nextpage> createState() => _nextpageState();
}

class _nextpageState extends State<nextpage> {
  bool isLoading=false;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title :Text('details'),
          backgroundColor: Colors.cyan,
        ),
        body:DecoratedBox(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/img_10.png"), fit: BoxFit.cover),
    ),
        child:Center(
          child: Container(
            //color: Colors.lightBlueAccent,
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on),
                Text('${widget.title}',
                  style:TextStyle(fontSize: 28),

                ),
                SizedBox(height: 20,),

                ElevatedButton(onPressed: (){
                  Navigator.pop(context, MaterialPageRoute(builder: (context) => weather(),
                  ));

                  setState(() {
                    isLoading = true;
                  });

                  Future.delayed(const Duration(seconds: 8), (){
                    setState(() {
                      isLoading = false;
                    });
                  });


                },

                  child:  isLoading? Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text('Loading...', style: TextStyle(fontSize: 20),),
                      const SizedBox(width: 10,),
                      const CircularProgressIndicator(color: Colors.blue,),
                    ],
                  ):

                  const Text('Refresh'),


                ),

                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(40.0),
                       child: Image.asset('assets/img.png',
                         height: 70,
                       ),
                     ),

                     Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Image.asset('assets/img_1.png',
                         height: 70,
                       ),
                     ),

                     Padding(
                       padding: const EdgeInsets.all(5.0),
                       child: Image.asset('assets/img_3.png',
                         height: 70,
                       ),
                     ),



                   ],

                )

              ],

            ),
          ),
        ),
      ),
      ),
    );
  }
}
