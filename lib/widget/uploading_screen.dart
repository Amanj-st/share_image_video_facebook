import 'dart:io';
import 'package:automoution1/facebook_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:video_player/video_player.dart'; 


class UploadScreen extends StatefulWidget {
  final int index;
  final String imgPath;
  final String title;
  final String subtitle;

  UploadScreen(this.index, this.imgPath, this.title, this.subtitle);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final FacebookService _facebookService = FacebookService();
  File? _pickedImage;
  File? _pickedVideo;
  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;


  Future<void> _pickImage() async {
    File? image = await _facebookService.pickImage();
    setState(() {
      _pickedImage = image;
    });
  }
  

  Future<void> _postImage() async {
    if (_pickedImage != null) {
      AccessToken? accessToken = await _facebookService.getAccessToken();
      if (accessToken != null) {
        await _facebookService.uploadImage(_pickedImage!.path, 'My Image', accessToken);
      } else {
        
        print('User is not logged in');
      }
    } else {
      print('No image selected');
    }
  }

  Future<void> _postImageToGroup() async {
    if (_pickedImage != null) {
      AccessToken? accessToken = await _facebookService.getAccessToken();
      if (accessToken != null) {
        await _facebookService.shareImageToFacebookGroups(_pickedImage!.path, 'My Image', );
      } else {
        
        print('User is not logged in');
      }
    } else {
      print('No image selected');
    }
  }
    Future<void> _pickVideo() async {
    File? video = await _facebookService.pickVideo();
    if (video != null) {
      _pickedVideo = video;
      _videoPlayerController = VideoPlayerController.file(video);
      _initializeVideoPlayerFuture = _videoPlayerController!.initialize();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }
  Future<void> _postVideo() async {
    if (_pickedImage != null) {
      AccessToken? accessToken = await _facebookService.getAccessToken();
      if (accessToken != null) {
        await _facebookService.uploadVideo(_pickedImage!.path, 'My Image', accessToken);
      } else {
        
        print('User is not logged in');
      }
    } else {
      print('No image selected');
    }
  }

  Future<void> _postVideoToGroup() async {
    if (_pickedImage != null) {
      AccessToken? accessToken = await _facebookService.getAccessToken();
      if (accessToken != null) {
        await _facebookService.shareVideoToFacebookGroups(_pickedImage!.path, 'My Image', );
      } else {
        
        print('User is not logged in');
      }
    } else {
      print('No image selected');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator:FloatingActionButtonAnimator.scaling ,
      floatingActionButton: widget.index == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadScreen(0, '2', widget.title, widget.subtitle)));
              },
              backgroundColor: Colors.amber,
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            )
          : null,
      floatingActionButtonLocation: widget.index == 1 ? FloatingActionButtonLocation.endFloat : null,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: widget.index == 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : Container(),
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        _pickedImage != null?
            Image.file(
               height: MediaQuery.of(context).size.width * 0.6,
            width: MediaQuery.of(context).size.height*0.8,
              _pickedImage!,
            )
            :  Container(
            height: MediaQuery.of(context).size.width * 0.6,
            width: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/4.png'),
              
                // image: AssetImage('assets/${widget.imgPath}.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
      //  Text(
      //       widget.title,
      //       style: const TextStyle(
      //         fontWeight: FontWeight.bold,
      //         fontSize: 40.5,
      //       ),
      //     ),
      //     const SizedBox(height: 15.0),
          // Padding(
            // padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          //   child: Text(
          //     widget.subtitle,
          //     textAlign: TextAlign.center,
          //     style: const TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 20.5,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 15.0),
          
         ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Pick Image'),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           
          ElevatedButton(
            onPressed: _postImage,
            child: const Text('Upload Image'),
          ),
     
      
            ElevatedButton(
            onPressed: _postImageToGroup,
            child: const Text('Shsre Image All Groups'),
          ),
        
      
        ],
      ),
       const Divider(color:Colors.amber,height: 3,),
           _pickedVideo != null
              ? FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return AspectRatio(
                        aspectRatio: _videoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController!),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ):Container(
            height: MediaQuery.of(context).size.width * 0.6,
            width: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/3.jpeg'),
              
                // image: AssetImage('assets/${widget.imgPath}.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
       ElevatedButton(
            onPressed: _pickVideo,
            child: const Text('Pick Video'),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           
          ElevatedButton(
            onPressed: _postVideo,
            child: const Text('Upload Video'),
          ),
     
      
            ElevatedButton(
            onPressed: _postImageToGroup,
            child: const Text('Shsre Video All Groups'),
          ),])
    ])
   );
  }
}
