
import 'package:flutter/material.dart';
import 'package:automoution1/facebook_service.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Secondpage extends StatefulWidget {
  final String accessToken;

  const Secondpage({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
        
         
          //....
            const Center(
            // child: Text("Access Token: ${widget.accessToken}"),
          ),
           
          ElevatedButton(
            onPressed: () async {
              FacebookService service = FacebookService();
              await service.getUserDetails();
            },
            child: const Text('Get User Detials'),
          ),
        
          ElevatedButton(
            onPressed: () async {
              FacebookService service = FacebookService();
              await service.getUserGroups();
            },
            child: const Text('Get User Groups'),
          ),
          ElevatedButton(
            onPressed: () async {
              FacebookService service = FacebookService();
              await service.shareToFacebookGroups('Your copied text here');
            },
            child: const Text('Share to Groups'),
          ),
        ],
      ),
    );
  }
}