import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'secondScraper.dart';
import 'opCalcPage.dart';

class MySecondPage extends StatefulWidget {
  const MySecondPage({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  int _counter = 0;
  String result1 = '';
  String result2 = '';
  String result3 = '';
  String selectedDate = '';
  String queryString = '';
  bool _firstClick = true;
  var counter = 0;
  bool isLoading = false;
  final myController = TextEditingController();
  TextEditingController _tickerEC = TextEditingController();
  List<String>  responseString= List<String>.empty(growable: true);
  List<OutlinedButton> buttonsList = List<OutlinedButton>.empty(growable: true);
@override
  Future<List<String>> extractData(query) async {

  queryString = query;
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
          '\$' + responseString1.text.trim(),
          '\$' + responseString2.text.trim(),
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
    @override
    List<Widget> _OptionsContractsDate(){
      for (int i = 0; i < responseString.length; i++) {
        buttonsList
            .add
          (OutlinedButton(onPressed: () async {


          Navigator.push(
            context,

            MaterialPageRoute(builder: (context) => opCalcPage(title: queryString.toUpperCase() + "/" + responseString[i])),
          );

             }

            , child:
            Text(responseString[i],

              style: TextStyle(fontFamily: 'ChakraPetch', fontSize: 23, color: Colors.black),
            ))
        );
      }
      return buttonsList;
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
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'calls',
          style: TextStyle(fontFamily: 'ChakraPetch', fontSize: 50, color: Colors.greenAccent),
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
            Padding(
              padding: const EdgeInsets.all(90.0),
              child: TextField(
              textAlign: TextAlign.center,
              controller: _tickerEC,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ticker entry'

              ),


              style: const TextStyle(fontFamily: 'ChakraPetch', fontSize: 30, color: Colors.black),
            ),
            ),
            Container(
              child:

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget> [

                    Text(result2,
                        style: TextStyle(fontFamily: 'ChakraPetch', fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(result1,
                        style: TextStyle(fontFamily: 'ChakraPetch', fontSize: 25,fontWeight: FontWeight.bold, color: Colors.black)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),

                    Text(result3,
                        style: TextStyle(fontFamily: 'ChakraPetch', fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black)),
                  ],

              ),
            ),



              Container(

                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    OutlinedButton(

                      onPressed: () async {

                        // Setting isLoading true to show the loader
                        setState(() {
                          isLoading = true;
                        });

                        // Awaiting for web scraping function
                        // to return list of strings
                        var query = _tickerEC.text;
                        final response = await extractData(query);



                          extractOptionData(query);

                        // Setting the received strings to be
                        // displayed and making isLoading false
                        // to hide the loader
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
                   margin: EdgeInsets.all(20),
                   child:
                       IntrinsicWidth(
                         child:
                         Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.stretch,

                           children: <Widget> [

                             const Text(
                               'Options Dates: ',
                               style: TextStyle(fontFamily: 'ChakraPetch',
                                   fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black),
                             ),

                               Wrap(
                                   children:
                                   _OptionsContractsDate()

                               ),


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


