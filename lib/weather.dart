import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart 'as http;
import 'package:weather1/weather_detail.dart';


class weather extends StatefulWidget {
  const weather({super.key});

  @override
  State<weather> createState() => _weatherState();
}
void main() {
  runApp(weather());
}

class _weatherState extends State<weather> {

  bool isLoading=false;

  TextEditingController _city = TextEditingController();
  String? city;
  double ?latt;
  double ?long;
  double ?tem;
  int ?pre;
  int ?hum;
  String? weather;


  
  void getloc() async {
    city = _city.text;

    final loc = await http.get(
        Uri.parse("http://api.openweathermap.org/geo/1.0/direct?"
            "q=$city,&limit=3&appid=faf559dbf83f46cbba809db5bc1ccd0e"));
    var data= jsonDecode(loc.body.toString());
    print(data);
    latt=data[0]['lat'];
    long=data[0]['lon'];
    print(latt);
    print(long);


    final wea = await http.get(
        Uri.parse("https://api.openweathermap.org/data/2.5/weather?"
            "lat=$latt&lon=$long&appid=faf559dbf83f46cbba809db5bc1ccd0e"));
    var data1= jsonDecode(wea.body.toString());

    print(data1);
    tem=data1['main']['temp'];
    pre=data1['main']['pressure'];
    hum=data1['main']['humidity'];
    print(tem);
    print(pre);
    print(hum);



    tem=data['main']['temp'];
    weather=data['weather'][0]['main'];
    if(weather=='clouds'){
      setState((){
        tem=data['main']['temp'];
      });
    }
  }



  @override

  void dispose() {
    // Clean up the controller
    // when the widget is disposed.
    _city.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('weather'),
          backgroundColor: Colors.cyan,
        ),
        body:DecoratedBox(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/img_7.png"), fit: BoxFit.cover),
    ),
       child: Center(
            child: Container(
              height: 400,  //height
              width: 350,   //weight
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,   //alignment in center
                children: [
                  TextField(style: TextStyle(fontSize: 20),
                    controller: _city,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black,width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.deepPurple,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),


                        labelText: "City",
                        labelStyle: TextStyle(fontSize: 25),
                        icon:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.location_city),
                        ),
                        contentPadding:EdgeInsets.only(left:10,right:10,),
                      )
                  ),
                  SizedBox(height: 30,),

                  ElevatedButton(onPressed:(){
                    //push the data to next page
                    Navigator.push(context, MaterialPageRoute(builder: (context) => nextpage( title: _city.text),


                    )
                    );

                    setState(() {
                      isLoading = true;
                    });

                    Future.delayed(const Duration(seconds: 5), (){
                     setState(() {
                         isLoading = false;
                     });
                    });

                       getloc();

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
                    const Text('Weather Info'),
                  ),


                ],
              ),
            ),
        ),
      ),
      ),
    );
  }
}


