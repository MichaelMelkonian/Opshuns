import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


// Strings to store the extracted Article titles
  String result1 = 'Result 1';
  String result2 = 'aResuqwdqdqdlt 2';
  String result3 = 'Result 3';

// boolean to show CircularProgressIndication
// while Web Scraping awaits
  bool isLoading = false;
Future<List<String>> extractTimeStamp(query) async {

  // Getting the response from the targeted url
  List<String>  responseString= List<String>.empty(growable: true);
  List<String>  tempStringHolder= List<String>.empty(growable: true);
  var contractMap = {};


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
    print("response String array");
    for(int i=0;i<responseString.length;i++)
    {

     // print(responseString[i]);
    }
    print("TempHolder Array");
    for(int i=0;i<tempStringHolder.length;i++)
    {

     // print(tempStringHolder[i]);
    }

    for(int i=0;i< responseString.length;i++)
    {
      contractMap[responseString[i]] = tempStringHolder[i];
    }

   // print("Contract Map Below");
   // print(contractMap);
    // String myString = "\$12,000.32";
    // myString = myString.replaceAll(",", "");
    // myString = myString.replaceAll("\$", "");
    // print(myString);
    // Scraping the first article title
    // var responseString1 = document
    //     .getElementsByTagName('option')[0];
    //
    // print(responseString1.text.trim());
    //
    // // Scraping the second article title
    // var responseString2 = document
    //     .getElementsByTagName('option')[1];
    //
    // print(responseString2.text.trim());
    //
    // // Scraping the third article title
    // var responseString3 = document
    //     .getElementsByTagName('option')[2];
    //
    //   print(responseString3.text.trim());

    // Converting the extracted titles into
    // string and returning a list of Strings
    return [
      // responseString1.text.trim(),
      // responseString2.text.trim(),
      // responseString3.text.trim()

    ];
    // } catch (e) {
    //   return ['', '', 'ERROR!'];
    // }
  } else {
    return ['', '', 'ERROR: ${response.statusCode}.'];
  }
}


// Future<List<String>> extractStrikeDataCalls(query,timestamp) async {
//
//     // Getting the response from the targeted url
//     List<String>  responseString= List<String>.empty(growable: true);
//     List<String>  tempStringHolder= List<String>.empty(growable: true);
//     var contractMap = {};
//
//
//     List<ElevatedButton> buttonsList = List<ElevatedButton>.empty(growable: true);
//
//     final response =
//     await http.Client().get(Uri.parse('https://finance.yahoo.com/quote/' +query +'/options?date=' + timestamp));
//
//     // Status Code 200 means response has been received successfully
//     if (response.statusCode == 200) {
//
//       // Getting the html document from the response
//       var document = parser.parse(response.body);
//       // try {
//
//       var responseString = <String>[];
//       //
//       for(int i=0;i<1500;i++)
//         {
//           try{
//             var resp1 = document.getElementsByTagName('tr')[i]
//                 .getElementsByTagName('td')[2].getElementsByTagName('a')[0].text;
//
//             var resp2 = document.getElementsByTagName('tr')[i-1]
//                 .getElementsByTagName('td')[2].getElementsByTagName('a')[0].text;
//             resp2 = resp2.replaceAll(",","");
//             resp1 = resp1.replaceAll(",","");
//             var newR1dub = double.parse(resp1);
//             var newR2dub = double.parse(resp2);
//             if( newR2dub>  newR1dub )
//             {
//
//               break;
//             }
//
//
//             responseString.add(resp1.toString());
//
//
//             print(resp1);
//
//           }
//            catch (e) {
//
//           }
//
//
//         }
//
//
//
//
//
//
//       for(int i=0;i<responseString.length;i++)
//         {
//           print(responseString[i]);
//         }
//
//
//       // String myString = "\$12,000.32";
//       // myString = myString.replaceAll(",", "");
//       // myString = myString.replaceAll("\$", "");
//       // print(myString);
//       // Scraping the first article title
//       // var responseString1 = document
//       //     .getElementsByTagName('option')[0];
//       //
//       // print(responseString1.text.trim());
//       //
//       // // Scraping the second article title
//       // var responseString2 = document
//       //     .getElementsByTagName('option')[1];
//       //
//       // print(responseString2.text.trim());
//       //
//       // // Scraping the third article title
//       // var responseString3 = document
//       //     .getElementsByTagName('option')[2];
//       //
//       //   print(responseString3.text.trim());
//
//         // Converting the extracted titles into
//         // string and returning a list of Strings
//         return [
//           // responseString1.text.trim(),
//           // responseString2.text.trim(),
//           // responseString3.text.trim()
//
//         ];
//       // } catch (e) {
//       //   return ['', '', 'ERROR!'];
//       // }
//     } else {
//      return ['', '', 'ERROR: ${response.statusCode}.'];
//     }
//   }
//
