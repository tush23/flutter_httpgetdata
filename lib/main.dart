import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


 void main () {
   runApp(new MaterialApp(
     home: new HomePage(),
   ));
 }
  class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => new _HomePageState();
  }

  class _HomePageState extends State<HomePage> {

   final String url = "http://www.json-generator.com/api/json/get/cjLmMWYhLm?indent=2";
   List data;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }
  Future<String> getJsonData() async{
     var response = await http.get(
     //for Encoding the Url
     Uri.encodeFull(url),
     //for accepting only json response);
       headers: {"Accept":"application/json"}
     );
     print(response.body);
     setState((){
       var converDatatoJson = JSON.decode(response.body);
       data = converDatatoJson['results'];
     });
     return 'Success';

  }

    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Retrive Json Using HTTP GET"),
        ),
        body: new ListView.builder(
          itemCount: data==null?0:data.length,
          itemBuilder: (BuildContext context,int index){
           return new Container(
              child: new Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Card(
                      child: new Row(
                        children: <Widget>[
                          new Container(
                                fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,fontSize: 15.0),
                           child:
                            new CircleAvatar(
                              backgroundImage: new NetworkImage(data[index]['picture']),
                             // child: new Text(data[index]['name'][0])
                            ),
                            margin: const EdgeInsets.all(20.0),
                          ),
                          new Container(
                            child:
                            new Column(
                              children: <Widget>[
                                new Container(
                                  child: new Text(data[index]['name'],style: new TextStyle(
                                      fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,fontSize: 15.0,),
                                  ),
                                ),
                                new Container(
                                  child: new Text("Website:"+data[index]['website'],style: new TextStyle(
                                      fontStyle: FontStyle.italic
                                  ),),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            );
          },
        ),
      );
    }
  }



