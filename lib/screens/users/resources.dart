import 'package:flutter/material.dart';
import 'package:jitenge/services/resource.dart';
import 'resources-detail.dart';
import 'package:jitenge/screens/users/userlist.dart';
import 'package:jitenge/screens/authenticate/sign-in.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<Resource> resources = [
    Resource(
        picture:
            'https://images.unsplash.com/photo-1584744982493-704a9eea4322?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
        datePosted: 'June 12th 2020',
        url:
            'http://c4c_api.mhealthkenya.org/storage/uploads/1592985162HCWs%20risk%20assesment%20tool.docx',
        description: 'Healthcare workers risk assesment tool for COVID 19',
        heading: 'Healthcare workers risk assesment tool'),
    Resource(
        picture:
            'https://images.unsplash.com/photo-1579544757872-ce8f6af30e0f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
        datePosted: 'June 10th 2020',
        url:
            'http://c4c_api.mhealthkenya.org/storage/uploads/1591774086Case%20management%20protocol.pdf',
        description:
            'Covid 19 Infection Prevention and Control (IPC) and Case Managememnt from the Ministry of Health.' +
                '\n' +
                'These consolidated guidelines provide recomendation for comprehensive prevention and case management strategies in Kenya',
        heading:
            'Covid 19 Infection Prevention and Control (IPC) and Case Managememnt from the Ministry of Health.'),
    Resource(
        picture:
            'https://images.unsplash.com/photo-1584634731339-252c581abfc5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80',
        datePosted: 'June 10th 2020',
        url:
            'http://c4c_api.mhealthkenya.org/storage/uploads/1591773868Kenya%20IPC_Considerations_For%20Health%20Care%20Settings.docx',
        description:
            'Attached is a document containing the Ministry of Health Interim Infections Prevention amd Control Recomendations for Coronovirus Disease 2019 (COVID-19) in Health Care Settings.',
        heading: 'Kenya IPC Considerations For Health Care Settings.')
  ];

  void updateTime(index) async {
    imageCache.clear();
    Resource instance = resources[index];
    await instance.getResource();
    // navigate to home screen and pass any data as well, eg location, flag
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResourcesDetail(
                url: instance.url,
                description: instance.description,
                heading: instance.heading,
                picture: instance.picture,
                datePosted: instance.datePosted,
              )),
      // );
    );
  }

  @override
  Widget build(BuildContext context) {
    print('inits function run');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        title: Text('Resources'),
        centerTitle: true,
        elevation: 3,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () => _exitApp(context)),
        ],
      ),
      body: ListView.builder(
          itemCount: resources.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Card(
                  child: Column(
                    children: [
                      Material(
                          child: InkWell(
                        onTap: () {
                          updateTime(index);
                        },
                        child: Container(
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              '${resources[index].picture}',
                              height: 150,
                              width: 340,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      )),

                      ListTile(
                        enabled: true,
                        //  isThreeLine: true,
                        onTap: () {
                          updateTime(index);
                        },

                        title: Text(resources[index].heading +
                            '  ' +
                            '\n' +
                            resources[index].datePosted),
                        subtitle: Text(resources[index].description),
                        //trailing: Text(resources[index].datePosted),
                      ),
                      SizedBox(
                        height: 20,
                      )
                      // ),
                      // Text(resources[index].heading)
                    ],
                  ),
                ));
          }),
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
            onPressed: () {},
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
