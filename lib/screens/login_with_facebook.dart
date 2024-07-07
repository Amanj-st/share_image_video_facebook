import 'package:automoution1/facebook_service.dart';
import 'package:automoution1/screens/ui_secondpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginWithFacebook extends StatefulWidget {
  const LoginWithFacebook({Key? key}) : super(key: key);

  @override
  _LoginWithFacebookState createState() => _LoginWithFacebookState();
}

String userEmail = "";

class _LoginWithFacebookState extends State<LoginWithFacebook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login With Facebook"),
      ),
      body: Center(
        child: ListView(
         
          children: [
             const SizedBox(height: 100,),
            //  Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text("User Email: $userEmail"),
            // ),
             Container(
            height: MediaQuery.of(context).size.width ,
            width: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/1.jpeg'),
            
                // image: AssetImage('assets/${widget.imgPath}.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
            const SizedBox(height: 20,),
           
            // ElevatedButton(
            //   onPressed: () async {
            //     await FirebaseAuth.instance.signOut();
            //     userEmail = "";
            //     await FacebookAuth.instance.logOut();
            //     setState(() {
            //       print("log out");
            //     });
            //   },
            //   child: const Text("Logout"),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: 
      
            MaterialButton(color: Colors.blue,
                    onPressed: () async {
                      FacebookService service = FacebookService();
                      AccessToken? accessToken = await service.login();
                      if (accessToken != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SharePage(accessToken: accessToken.tokenString),
                          )  );
                          
                           await service.getUserDetails();
                           setState(() {
                            
                          });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to login with Facebook')),
                        );
                      }
                    },
                    child:  Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: const Icon(Icons.facebook,color: Colors.blue,size: 25,)),
                          const SizedBox(width:   10),
                        const Text("Login with Facebook",style:TextStyle(color: Colors.white,fontSize: 18)),
                      ],
                    ),
                  ),
              
        
      
    );
  }
}
