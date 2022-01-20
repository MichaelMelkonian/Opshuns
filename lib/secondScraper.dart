import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;


class shareCalc extends StatefulWidget {
  const shareCalc({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  State<shareCalc> createState() => _shareCalcState();
}

class _shareCalcState extends State<shareCalc> {
  int _counter = 0;
  String result1 = '';
  String result2 = '';
  String result3 = '';

  double resultToDub = 0.0;


  bool isLoading = false;
  final myController = TextEditingController();
  TextEditingController _tickerEC = TextEditingController();
  TextEditingController _shareQT = TextEditingController();
  TextEditingController _priceT = TextEditingController();

  List<String>  responseString= List<String>.empty(growable: true);
  List<ElevatedButton> buttonsList = List<ElevatedButton>.empty(growable: true);
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
           '\$'+ responseString1.text.trim(),
          '\$'+ responseString2.text.trim(),
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
  void dispose()
  {
    myController.dispose();
    super.dispose();
  }

  double calculator(double stockCurrent, double shareQuantity, double priceTarget)
  {
    var profit = 0.0;
    profit = (priceTarget * shareQuantity) - (stockCurrent * shareQuantity);


    return profit;

  }


  void _incrementCounter() {
    setState(() {

      _counter++;

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'share calc',
          style: TextStyle(fontFamily: 'ChakraPetch', fontSize: 40, color: Colors.blueAccent),
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
              margin: EdgeInsets.all(20),
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
                ],

              ),



            ),
            Container(

              child:
                Row(
                  children: <Widget>[
                    Expanded(
                      child:
                      TextField(
                        textAlign: TextAlign.center,
                        controller: _shareQT,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'share qty'

                        ),


                        style: const TextStyle(fontFamily: 'ChakraPetch', fontSize: 30, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child:
                      TextField(
                        textAlign: TextAlign.center,
                        controller: _priceT,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'price target'

                        ),


                        style: const TextStyle(fontFamily: 'ChakraPetch', fontSize: 30, color: Colors.black),
                      ),
                    ),

                  ],

                ),


            ),

            OutlinedButton(

              onPressed: () async {

                // Setting isLoading true to show the loader
                setState(() {
                  isLoading = true;
                });

                // Awaiting for web scraping function
                // to return list of strings
                var query = _tickerEC.text;

                double shareQuan = double.parse(_shareQT.text);
                double targetPrice = double.parse(_priceT.text);


                double goalProfit = shareQuan + targetPrice;
                final response = await extractData(query);

                // Setting the received strings to be
                // displayed and making isLoading false
                // to hide the loader
                setState(() {
                  // result1 = response[0];
                  // result2 = response[1];
                  // result3 = response[2];
                var newResult1 = result1.replaceAll(",","");
                newResult1 = newResult1.replaceAll("\$","");
                // result1 = result1.replaceAll(",","");
                // result1 = result1.replaceAll("\$","");


                  resultToDub = double.parse(newResult1);
                  assert(resultToDub is double);


                  resultToDub = calculator(resultToDub,shareQuan,targetPrice);
                  isLoading = false;


                });

              },

              child: const Icon(Icons.calculate, size: 40, color: Colors.black),

            ),
            Container(
              margin: EdgeInsets.all(40),

              child:

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget> [
                  const Text(
                    'proj. earnings',
                      style: TextStyle(fontFamily: 'ChakraPetch', fontSize: 24, color: Colors.black)
                  ),

                  Text('+\$' + resultToDub.toString().split('.')[0],

                      style: TextStyle(fontFamily: 'ChakraPetch', fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),


                ],

              ),
            ),

          ],
        ),
      ),

  // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
