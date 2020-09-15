import 'package:flutter/material.dart';
import 'dart:async';
import 'resources.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jitenge/screens/authenticate/sign-in.dart';
import 'package:jitenge/screens/users/userlist.dart';

//import 'dart:html' as html;

class ResourcesDetail extends StatefulWidget {
  var url;

  var datePosted;

  var picture;

  var description;

  var heading;

  ResourcesDetail(
      {Key key,
      this.url,
      this.picture,
      this.heading,
      this.description,
      this.datePosted})
      : super(key: key);
  @override
  _ResourcesDetailState createState() => _ResourcesDetailState();
}

class _ResourcesDetailState extends State<ResourcesDetail> {
  @override
  void initState() {
    String url = widget.url;
    String picture = widget.picture;
    String heading = widget.heading;
    String description = widget.description;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String url = widget.url;
    String picture = widget.picture;
    String heading = widget.heading;
    String description = widget.description;
    String datePosted = widget.datePosted;

    //set background
    String bgImage = '$picture' != null ? '$picture' : 'jitenge.png';
    // Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Jitenge - Resources'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 3.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () => _exitApp(context)),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              //color: Colors.white60,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .35,
              child: Image.network(
                '$picture',
                width: 800,
                height: 200,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  borderOnForeground: true,
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Material(
                        elevation: 24.0,
                        child: Column(children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                              child: Column(
                                children: [
                                  Text(
                                    '\n' + '$heading' + '\n',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      // letterSpacing: 1.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text('Posted on: $datePosted' + '\n'),
                                ],
                              )),
                        ]),
                      ),
                      // ),

                      // ),
                      // Text(resources[index].heading)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  borderOnForeground: true,
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Material(
                        elevation: 24.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Post',
                                  style: TextStyle(
                                    height: 2,
                                    fontSize: 18.0,
                                    //letterSpacing: 1.0,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '$description',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black45,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Additional files.',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RaisedButton(
                                    color: Colors.white,
                                    elevation: 5,
                                    onPressed: () {
                                      //const url = 'https://google.com';
                                      launch(url);
                                    },
                                    child: new Row(
                                      children: [
                                        Icon(
                                          Icons.file_download,
                                          color: Colors.blue,
                                          size: 18.0,
                                          semanticLabel:
                                              'Text to announce in accessibility modes',
                                        ),
                                        Text(
                                          ' Download document from browser.',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ],
                                    )),
                              ]),
                        ),
                      ),
                      // ),

                      // ),
                      // Text(resources[index].heading)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
          // ),
        ]),
      ),
      // ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlatButton.icon(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            //color: Colors.white,
            //elevation: 2.0,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.home, color: Colors.blue[600]),
            label: Text(
              'Home',
              style: TextStyle(
                  color: Colors.blue[600],
                  //letterSpacing: 2.0,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          FlatButton.icon(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            //color: Colors.white,
            //elevation: 2.0,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.assignment, color: Colors.blue[600]),
            label: Text(
              'Resources',
              style: TextStyle(
                  color: Colors.blue[400],
                  //letterSpacing: 2.0,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          FlatButton.icon(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            //color: Colors.white,
            //elevation: 2.0,
            onPressed: () {
              _exitApp(context);
            },
            icon: Icon(Icons.exit_to_app, color: Colors.blue[600]),
            label: Text(
              'Logout',
              style: TextStyle(
                  color: Colors.blue[400],
                  //letterSpacing: 2.0,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool> _exitApp(BuildContext context) {
  return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Logout from Jitenge.'),
          content: Text('Are you sure you want to log out?'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.white)),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  //arguments: {},
                  MaterialPageRoute(builder: (context) => SignIn()),
                  (Route<dynamic> route) => false,
                );
                //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: Text('Yes'),
            ),
          ],
        ),
      ) ??
      false;
}
