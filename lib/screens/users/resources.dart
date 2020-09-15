import 'package:flutter/material.dart';
import 'package:jitenge/services/resource.dart';
import 'resources-detail.dart';

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
        url: 'https://google.com',
        description: 'Healthcare workers risk assesment tool for COVID 19',
        heading: 'Healthcare workers risk assesment tool'),
    Resource(
        picture:
            'https://images.unsplash.com/photo-1579544757872-ce8f6af30e0f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
        datePosted: 'June 10th 2020',
        url: 'https://google.com',
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
        url: 'https://google.com',
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
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: resources.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Card(
                  child: Column(
                    children: [
                      Image.network('${resources[index].picture}'),
                      ListTile(
                        onTap: () {
                          updateTime(index);
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${resources[index].picture}'), // no matter how big it is, it won't overflow
                        ),
                        title: Text(resources[index].heading +
                            '  ' +
                            '\n' +
                            resources[index].datePosted),
                        subtitle: Text(resources[index].description),
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
    );
  }
}
