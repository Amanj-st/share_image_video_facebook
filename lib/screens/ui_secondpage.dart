import 'package:automoution1/facebook_service.dart';
import 'package:automoution1/widget/card_text.dart';
import 'package:automoution1/widget/uploading_screen.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:twitter_login/schemes/access_token.dart';

class SharePage extends StatefulWidget {
  final String accessToken;

  const SharePage({super.key, required this.accessToken});

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  List<String> labels = ["Phone", "Video", "Audio", "Document"];
  int currentIndex = 0;
  String tit = 'Upload File';
  String sub = 'Browse and choose the files you want to upload.';
  Map<String, dynamic>? userDetails;
AccessToken? accessToken;
 @override
  void initState() {
   fetchUserDetails();
    super.initState();
  }

   FacebookService service = FacebookService();
   Future<void> fetchUserDetails() async {
    var details = await service.getUserDetails();
    setState(() {
      userDetails = details;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      backgroundColor: Colors.amber,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UploadScreen(1, '1', tit, sub)));
        },
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {},
              ),
              SizedBox(
                  width: 125.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.filter_list),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu),
                        color: Colors.white,
                        onPressed: () {},
                      )
                    ],
                  ))
            ],
          ),
        ),
        const SizedBox(height: 25.0),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: email,
              ),
              const SizedBox(width: 10.0),
            ],
          ),
        ),
        const SizedBox(height: 40.0),
        Container(
          height: MediaQuery.of(context).size.height - 185.0,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0)),
          ),
          child: ListView(
            primary: false,
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ToggleSwitch(
                        minWidth: 90.0,
                        cornerRadius: 20.0,
                        activeBgColors: const [
                          [Colors.amber],
                          [Colors.amber],
                          [Colors.amber],
                          [Colors.amber]
                        ],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.black,
                        inactiveFgColor: Colors.white,
                        initialLabelIndex: currentIndex,
                        labels: labels,
                        onToggle: (index) {
                          setState(() {
                            currentIndex = index!;
                          });
                        },
                        totalSwitches: 4,
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.all(25),
                          children: [
                         
              
                            MyCard(
                              color: Colors.amber,
                              title:userDetails.toString(),
                              onTap: () {
                                print("upload");
                              },
                            ),
                            MyCard(
                              color: Colors.amberAccent,
                              title: 'Rehersals',
                              onTap: () {},
                            ),
                            MyCard(
                              color: Colors.grey,
                              title: 'Audio',
                              onTap: () {},
                            ),
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
      ]),
    );
  }
}
