
import 'package:automoution1/screens/login_with_facebook.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 Future<void> requestPermissions() async {
    // Request camera and storage permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();

    print("Camera permission: ${statuses[Permission.camera]}");
    print("Storage permission: ${statuses[Permission.storage]}");
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select Option"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginWithGoogle()));
            //     },
            //     child: const Text("Login with google")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginWithFacebook()));
                },
                child: const Text("Login with facebook")),

            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginWithPhone()));
            //     },
            //     child: const Text("Login with Phone")),

            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginWithTwitter()));
            //     },
            //     child: const Text("Login with Twitter"))
          ],
        ),
      ),
    );
  }
}