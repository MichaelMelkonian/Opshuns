import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:my_first_flutter_project/web_scraper.dart';
import 'secondScraper.dart';
import 'next_page.dart';

class opCalcPage extends StatefulWidget {
  const opCalcPage({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  State<opCalcPage> createState() => _opCalcPageState();
}

class _opCalcPageState extends State<opCalcPage> {


  TextEditingController _contractQT = TextEditingController();
  TextEditingController _futureStockPrice = TextEditingController();
  TextEditingController _striker = TextEditingController();
  TextEditingController _contractPrice = TextEditingController();


  int _counter = 0;
  double callProf = 0.0;
  String result1 = '';
  String result2 = '';
  String result3 = '';
  bool _firstClick = true;
  var counter = 0;
  bool isLoading = false;
  var contractMap = {};
  final myController = TextEditingController();
  TextEditingController _tickerEC = TextEditingController();
  List<String>  responseString= List<String>.empty(growable: true);
  List<String>  strikeString= List<String>.empty(growable: true);

  List<OutlinedButton> buttonsList = List<OutlinedButton>.empty(growable: true);
  @override
  Future<List<String>> extractData(query) async {

    // Getting the response from the targeted url
    var URL = 'https://finance.yahoo.com/quote/';
    final response =
    await http.Client().get(Uri.parse(URL +query.toUpperCase()));

    // Status Code 200 means response has been received successfully
    if (response.statusCode == 200) {

      // Getting the html document from the response
      var document = parser.parse(response.body);
      try {

        // Scraping the first article title
        // Scraping the first article title
        var responseString1 = document
            .getElementsByTagName('fin-streamer')[18];

        print(responseString1.text.trim());

        // Scraping the second article title
        var responseString2 = document
            .getElementsByTagName('fin-streamer')[19];

        print(responseString2.text.trim());

        // Scraping the third article title
        var responseString3 = document
            .getElementsByTagName('fin-streamer')[20];

        // Converting the extracted titles into
        // string and returning a list of Strings
        return [
          responseString1.text.trim(),
          responseString2.text.trim(),
          responseString3.text.trim()
        ];
      } catch (e) {
        return ['', '', 'enter valid ticker'];
      }
    } else {
      return ['', '', 'ERROR: ${response.statusCode}.'];
    }
  }




  @override
  void extractOptionData(query) async {

    // Getting the response from the targeted url


    final response =
    await http.Client().get(Uri.parse('https://finance.yahoo.com/quote/'+ query+'/options'));

    // Status Code 200 means response has been received successfully
    if (response.statusCode == 200) {

      // Getting the html document from the response
      var document = parser.parse(response.body);
      // try {

      //var responseString = <String>[];

      for(int i=0;i<100;i++)
      {
        try{
          var resp1 = document
              .getElementsByTagName('option')[i];
          responseString.add(resp1.text.toString());
        }
        catch (e) {

        }


      }
    }
  }
  Future<Object> extractTimeStamp(query) async {

    // Getting the response from the targeted url
    List<String>  responseString= List<String>.empty(growable: true);
    List<String>  tempStringHolder= List<String>.empty(growable: true);



    List<ElevatedButton> buttonsList = List<ElevatedButton>.empty(growable: true);

    final response =
    await http.Client().get(Uri.parse('https://finance.yahoo.com/quote/' + query+ '/options'));

    // Status Code 200 means response has been received successfully
    if (response.statusCode == 200) {

      // Getting the html document from the response
      var document = parser.parse(response.body);
      // try {

      //var responseString = <String>[];

      for(int i=0;i<100;i++)
      {
        try{
          var resp1 = document
              .getElementsByTagName('option')[i];
          responseString.add(resp1.text.toString());
          tempStringHolder.add(resp1.text.toString());
        }
        catch (e) {

        }
        // var resp1 = document
        //     .getElementsByTagName('option')[i];
        // responseString.add(resp1.text.toString());

      }


      for(int i=0;i<responseString.length;i++)
      {

        tempStringHolder[i] = tempStringHolder[i].replaceAll("January","01");
        tempStringHolder[i] =tempStringHolder[i].replaceAll("February","02");
        tempStringHolder[i] =tempStringHolder[i].replaceAll("March","03");
        tempStringHolder[i] =tempStringHolder[i].replaceAll("April","04");
        tempStringHolder[i] =tempStringHolder[i].replaceAll("May","05");
        tempStringHolder[i] =tempStringHolder[i].replaceAll("June","06");
        tempStringHolder[i] = tempStringHolder[i].replaceAll("July","07");
        tempStringHolder[i] =tempStringHolder[i].replaceAll("August","08");
        tempStringHolder[i] =tempStringHolder[i].replaceAll("September","09");
        tempStringHolder[i] =tempStringHolder[i].replaceAll("October","10");
        tempStringHolder[i] =tempStringHolder[i].replaceAll("November","11");
        tempStringHolder[i] =tempStringHolder[i].replaceAll("December","12");
        tempStringHolder[i] =tempStringHolder[i].replaceAll(",","");
      }

      for(int i=0;i<responseString.length;i++)
      {

        tempStringHolder[i] = tempStringHolder[i].replaceAll(" ","-");

      }
      String month = "";
      String day = "";
      String year = "";

//Creates equal date length for string to easily be converted to UTC value
      for(int i=0;i<tempStringHolder.length;i++)
      {
        if(tempStringHolder[i].length < 10)
        {
          tempStringHolder[i] = tempStringHolder[i].substring(0,3) + "0" + tempStringHolder[i].substring(3,9);
        }
      }



      for(int i=0;i<tempStringHolder.length;i++)
      {
        month = tempStringHolder[i].substring(0,2);
        day = tempStringHolder[i].substring(3,5);
        year = tempStringHolder[i].substring(6,10);
        var yearNum = int.parse(year);
        var monthNum = int.parse(month);
        var dayNum = int.parse(day);
        DateTime date1 = DateTime(yearNum,monthNum, dayNum);
        var timestamp1 = (date1.millisecondsSinceEpoch / 1000)-28800;
        String timeStampString = timestamp1.toString();
        var splitStamp = timeStampString.split('.');
        timeStampString = splitStamp[0];
        // print("This is a timestamp string: " + timeStampString);
        tempStringHolder[i] = timeStampString;

      }


      for(int i=0;i< responseString.length;i++)
      {
        contractMap[responseString[i]] = tempStringHolder[i];
      }

      print("Contract Map Below");
      print(contractMap);


      return contractMap;

    } else {
      return ['', '', 'ERROR: ${response.statusCode}.'];
    }
  }
  Future<Object> extractStrikeDataCalls(query,timestamp) async {

    // Getting the response from the targeted url

    List<ElevatedButton> buttonsList = List<ElevatedButton>.empty(growable: true);
    var strikeURL = 'https://finance.yahoo.com/quote/'+query+'/options?date='+timestamp+'&p='+query;
    final response =
    await http.Client().get(Uri.parse(strikeURL));

    // Status Code 200 means response has been received successfully
    if (response.statusCode == 200) {

      // Getting the html document from the response
      var document = parser.parse(response.body);
      // try {

      var responseString = <String>[];
      //
      for(int i=0;i<500;i++)
      {
        try{
          var resp1 = document.getElementsByTagName('tr')[i]
              .getElementsByTagName('td')[2].getElementsByTagName('a')[0].text;

          var resp2 = document.getElementsByTagName('tr')[i-1]
              .getElementsByTagName('td')[2].getElementsByTagName('a')[0].text;
          resp2 = resp2.replaceAll(",","");
          resp1 = resp1.replaceAll(",","");
          var newR1dub = double.parse(resp1);
          var newR2dub = double.parse(resp2);
          if( newR2dub>  newR1dub )
          {

            break;
          }


          strikeString.add(resp1.toString());




        }
        catch (e) {

        }


      }

      for(int i=0;i<responseString.length;i++)
      {
        print(responseString[i]);
      }


      // Converting the extracted titles into
      // string and returning a list of Strings
      return contractMap;
      // } catch (e) {
      //   return ['', '', 'ERROR!'];
      // }
    } else {
      return ['', '', 'ERROR: ${response.statusCode}.'];
    }
  }

  @override
  List<Widget> _OptionsContractsStrike(){
    for (int i = 0; i < strikeString.length; i++) {
      buttonsList
          .add
        (OutlinedButton(onPressed: null

          , child:
          Text(strikeString[i],

            style: TextStyle(fontFamily: 'ChakraPetch', fontSize: 23, color: Colors.black),
          ))
      );
    }
    return buttonsList;
  }
  double callCalc(double expectedPrice,double strike,double contractPrice)
  {
    var earnings = 0.0;
    expectedPrice = 54.24;


    earnings = ((expectedPrice - strike) - contractPrice)*100;
    return earnings;
  }
  @override
  void dispose()
  {
    myController.dispose();
    super.dispose();
  }
  @override
  void _incrementCounter() {
    setState(() {

      _counter++;

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(

          widget.title,
          style: TextStyle(fontFamily: 'ChakraPetch', fontSize: 20, color: Colors.orangeAccent),
        ),

      ),

      body: SingleChildScrollView(

        // Center is a layout widget. It takes a single child and positions it,
        // in the middle of the parent.

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            const Text(
              '',
              style: TextStyle(fontFamily: 'ChakraPetch', fontSize: 30, color: Colors.black),
            ),




            Container(

              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [



                  Container(

                    child:
                    Column(
                      children: <Widget>[

                          TextField(
                            textAlign: TextAlign.center,
                            controller: _contractQT,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'contract qt.'

                            ),


                            style: const TextStyle(fontFamily: 'ChakraPetch', fontSize: 30, color: Colors.black),
                          ),
                        TextField(
                          textAlign: TextAlign.center,
                          controller: _contractPrice,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'contract price.'

                          ),


                          style: const TextStyle(fontFamily: 'ChakraPetch', fontSize: 30, color: Colors.black),
                        ),




                        TextField(
                            textAlign: TextAlign.center,
                            controller: _striker,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'strike price'

                            ),


                            style: const TextStyle(fontFamily: 'ChakraPetch', fontSize: 30, color: Colors.black),
                          ),


                        TextField(
                          textAlign: TextAlign.center,
                          controller: _futureStockPrice,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'price target'

                          ),


                          style: const TextStyle(fontFamily: 'ChakraPetch', fontSize: 30, color: Colors.black),
                        ),
                      ],

                    ),


                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child:
                    IntrinsicWidth(
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: <Widget> [

                          const Text(
                            '',
                            style: TextStyle(fontFamily: 'ChakraPetch',
                                fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black),
                          ),

                          Wrap(
                              children:
                              _OptionsContractsStrike()

                          ),
                          OutlinedButton(

                            onPressed: () async {

                              // Setting isLoading true to show the loader
                              setState(() {
                                isLoading = true;
                              });


                              // Awaiting for web scraping function
                              // to return list of strings
                              var query = widget.title.split("/")[0];
                              var date = widget.title.split("/")[1];
                              print(query);
                              print(date);
                              double contractQuan = double.parse(_contractPrice.text);
                              double targPrice = double.parse(_futureStockPrice.text);
                              double strikePrice = double.parse(_striker.text);
                              final response = await extractData(query);

                              callProf = (callCalc(targPrice,strikePrice,contractQuan) * contractQuan)*100;

                              extractOptionData(query);
                              var newHashStamp = extractTimeStamp(query);
                              // print(contractMap[date]);
                              print(newHashStamp);

                              setState(() {
                                result1 = response[0];
                                result2 = response[1];
                                result3 = response[2];

                                isLoading = false;
                              });
                            },

                            child: const Icon(Icons.arrow_drop_up_rounded, size: 40, color: Colors.black),

                          ),


                          Container(
                            child:
                              Row(
                                children: <Widget> [
                                const Text(
                                'Proj. Earn:',
                                  style: const TextStyle(fontFamily: 'ChakraPetch', fontSize: 30, color: Colors.black),
                              ),
                                  Text(
                                     '\$1,245.23',
                                    style: const TextStyle(fontFamily: 'ChakraPetch', fontSize: 12,fontWeight: FontWeight.bold, color: Colors.black),
                                  )
                                ],
                          ),



                          )

                        ],

                      ),
                    ),


                  ),

                ],

              ),



            ),




          ],
        ),
      ),


    );
  }
}


