import 'package:flutter/material.dart';
import 'package:my_first_flutter_project/secondScraper.dart';
import 'next_page.dart';
import 'another_page.dart';
import 'web_scraper.dart';
import 'secondScraper.dart';

//import 'package:html/dom.dart' as dom;


void main() {
  //extractStrikeDataCalls('TSLA','1643328000');
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {





    return MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // primarySwatch: Colors.green,

      ),
      home: const MyHomePage(title: 'Michaels Flutter Homepage'),



    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0;

  void _CallPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MySecondPage(title: 'CALLS')),
    );
  }
  void _shareCalc() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;

    });
    Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => shareCalc(title: 'SHARE CALC')),
    );
  }

  void _PutPage() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
     // _counter++;

    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyThirdPage(title: 'PUTS')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(

        backgroundColor: Colors.black,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.

        title: Text(
            'opshuns',
          style: TextStyle(fontFamily: 'ChakraPetch', fontSize: 40),





        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(


          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // TextField(
            //   style: TextStyle(color:Colors.white),
            //   decoration: InputDecoration(
            //     focusColor: Colors. white, filled: true,
            //
            //     border: OutlineInputBorder(
            //
            //     ),
            //     hintText: 'Enter Ticker',
            //
            //
            //   ),
            // ),

            Container(
              margin: EdgeInsets.all(40),
              height: 200,
              width: 200,
              child:
              const Image(
                image: AssetImage('assets/images/AppLogo.png'),

                // fit: BoxFit.fitWidth,
                fit: BoxFit.fitHeight,

              ),
            ),


          Container(
            // margin: EdgeInsets.all(20),
            child:
            TextButton.icon(
              onPressed: _CallPage,

              label: const Text(
                'calls',
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'ChakraPetch',
                  fontSize: 40,
                ),
              ),
              icon: Icon(Icons.arrow_drop_up_rounded, size: 90,color: Colors.green),
            ),
          ),
            Container(
              // margin: EdgeInsets.all(20),
              child:
              TextButton.icon(
                onPressed: _PutPage,

                icon: Icon(Icons.arrow_drop_down_rounded, size: 90,color: Colors.red),

                label: const Text(
                  'puts',
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'ChakraPetch',
                    fontSize: 40,
                  ),
                ),

              ),
            ),

            Container(
              // margin: EdgeInsets.all(20),
              child:
              TextButton.icon(
                onPressed: _shareCalc,

                icon: Icon(Icons.waterfall_chart, size: 50,color: Colors.blue),

                label: const Text(
                  'share calc',
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'ChakraPetch',
                    fontSize: 40,
                  ),
                ),

              ),
            ),

            // TextButton.icon(
            //   onPressed: _Scraper,
            //
            //   label: const Text(
            //     'scraper',
            //     style: TextStyle(
            //       color: Colors.blue,
            //       fontFamily: 'ChakraPetch',
            //       fontSize: 40,
            //     ),
            //   ),
            //   icon: Icon(Icons.arrow_drop_up_rounded, size: 90,color: Colors.blue),
            // ),

            // Text(
            //   '$_counter',
            //   style: TextStyle (
            //     color: Colors.red,
            //     fontFamily: 'NunitoSans',
            //     fontSize: 40,
            //   ),//Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),

      ),

      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.green,
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.mobile_screen_share),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,//
    );
  }
}
