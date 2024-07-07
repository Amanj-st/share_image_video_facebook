import 'dart:convert';
import 'dart:io';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class FacebookService {
  final ImagePicker _picker = ImagePicker();

  Future<AccessToken?> login() async {
    final LoginResult result = await FacebookAuth.instance.login(
      loginBehavior: LoginBehavior.nativeWithFallback,
      permissions: [
        'public_profile', 'email', 'user_birthday', 'user_videos', 'user_age_range',
        'user_friends', 'user_gender', 'user_hometown', 'user_likes', 'user_link',
        'user_location', 'user_videos', 'user_posts', 'user_photos'
      ],
    );

    if (result.status == LoginStatus.success) {
      print("Token: ${result.accessToken!.tokenString}");
      return result.accessToken;
    } else {
      print("Error: ${result.message}");
      print("Status: ${result.status}");
      return null;
    }
  }

  Future<AccessToken?> getAccessToken() async {
    return await FacebookAuth.instance.accessToken;
  }

  Future<void> logout() async {
    await FacebookAuth.instance.logOut();
  }

  Future<void> postToFeed(String message, AccessToken accessToken) async {
    final response = await http.post(
      Uri.parse('https://graph.facebook.com/v14.0/me/feed'),
      body: {
        'message': message,
        'access_token': accessToken.tokenString,
      },
    );
    if (response.statusCode == 200) {
      print('Post successful');
    } else {
      print('Failed to post: ${response.body}');
    }
  }

  Future<void> postToGroup(String groupId, String message, AccessToken accessToken) async {
    final response = await http.post(
      Uri.parse('https://graph.facebook.com/v14.0/$groupId/feed'),
      body: {
        'message': message,
        'access_token': accessToken.tokenString,
      },
    );
    if (response.statusCode == 200) {
      print('Post successful');
    } else {
      print('Failed to post: ${response.body}');
    }
  }

  Future<List<String>> getUserGroups() async {
    AccessToken? accessToken = await getAccessToken();
    final response = await http.get(
      Uri.parse('https://graph.facebook.com/v14.0/me/groups?access_token=${accessToken!.tokenString}'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<String> groupIds = [];
      for (var group in data['data']) {
        groupIds.add(group['id']);
      }
      return groupIds;
    } else {
      print('Failed to fetch groups: ${response.body}');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getUserDetails() async {
    AccessToken? accessToken = await getAccessToken();
    final response = await http.get(
      Uri.parse('https://graph.facebook.com/v14.0/me?fields=id,name,email&access_token=${accessToken!.tokenString}'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      print('Failed to fetch user details: ${response.body}');
      return null;
    }
  }

  Future<void> shareToFacebookGroups(String text) async {
    try {
      AccessToken? accessToken = await getAccessToken();
      var groupsResponse = await http.get(
        Uri.parse('https://graph.facebook.com/v14.0/me/groups?access_token=${accessToken!.tokenString}'),
      );

      if (groupsResponse.statusCode == 200) {
        List<dynamic> groups = jsonDecode(groupsResponse.body)['data'];
        for (var group in groups) {
          var groupId = group['id'];
          var shareResponse = await http.post(
            Uri.parse('https://graph.facebook.com/v14.0/$groupId/feed'),
            headers: {
              'Authorization': 'Bearer ${accessToken.tokenString}',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'message': text}),
          );

          if (shareResponse.statusCode == 200) {
            print('Shared to group: $groupId');
          } else {
            print('Failed to share to group: $groupId');
          }
        }
      } else {
        print('Failed to fetch groups: ${groupsResponse.statusCode}');
      }
    } catch (e) {
      print('Error sharing to Facebook: $e');
    }
  }

  Future<void> uploadVideo(String videoPath, String description, AccessToken accessToken) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://graph-video.facebook.com/v14.0/me/videos'),
    );
    request.fields['description'] = description;
    request.fields['access_token'] = accessToken.tokenString;
    request.files.add(await http.MultipartFile.fromPath('source', videoPath));
    
    var response = await request.send();
    
    if (response.statusCode == 200) {
      print('Video upload successful');
    } else {
      print('Failed to upload video: ${response.reasonPhrase}');
    }
  }

Future<void> uploadImage(String imagePath, String caption, AccessToken accessToken) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://graph.facebook.com/v14.0/me/photos'),
    );
    request.fields['caption'] = caption;
    request.fields['access_token'] = accessToken.tokenString;
    request.files.add(await http.MultipartFile.fromPath('source', imagePath));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image upload successful');
    } else {
      print('Failed to upload image. Status Code: ${response.statusCode}');
      print('Reason: ${response.reasonPhrase}');
      print(await response.stream.bytesToString());
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
}

  Future<void> shareVideoToFacebookGroups(String videoPath, String description) async {
    try {
      AccessToken? accessToken = await getAccessToken();
      var groupsResponse = await http.get(
        Uri.parse('https://graph.facebook.com/v14.0/me/groups?access_token=${accessToken!.tokenString}'),
      );

      if (groupsResponse.statusCode == 200) {
        List<dynamic> groups = jsonDecode(groupsResponse.body)['data'];
        for (var group in groups) {
          var groupId = group['id'];
          var request = http.MultipartRequest(
            'POST',
            Uri.parse('https://graph-video.facebook.com/v14.0/$groupId/videos'),
          );
          request.fields['description'] = description;
          request.fields['access_token'] = accessToken.tokenString;
          request.files.add(await http.MultipartFile.fromPath('source', videoPath));
          
          var response = await request.send();
          
          if (response.statusCode == 200) {
            print('Shared video to group: $groupId');
          } else {
            print('Failed to share video to group: ${response.reasonPhrase}');
          }
        }
      } else {
        print('Failed to fetch groups: ${groupsResponse.statusCode}');
      }
    } catch (e) {
      print('Error sharing video to Facebook: $e');
    }
  }

  Future<void> shareImageToFacebookGroups(String imagePath, String caption) async {
    try {
      AccessToken? accessToken = await getAccessToken();
      var groupsResponse = await http.get(
        Uri.parse('https://graph.facebook.com/v14.0/me/groups?access_token=${accessToken!.tokenString}'),
      );

      if (groupsResponse.statusCode == 200) {
        List<dynamic> groups = jsonDecode(groupsResponse.body)['data'];
        for (var group in groups) {
          var groupId = group['id'];
          var request = http.MultipartRequest(
            'POST',
            Uri.parse('https://graph.facebook.com/v14.0/$groupId/photos'),
          );
          request.fields['caption'] = caption;
          request.fields['access_token'] = accessToken.tokenString;
          request.files.add(await http.MultipartFile.fromPath('source', imagePath));
          
          var response = await request.send();
          
          if (response.statusCode == 200) {
            print('Shared image to group: $groupId');
          } else {
            print('Failed to share image to group: ${response.reasonPhrase}');
          }
        }
      } else {
        print('Failed to fetch groups: ${groupsResponse.statusCode}');
      }
    } catch (e) {
      print('Error sharing image to Facebook: $e');
    }
  }

  Future<File?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
     return File(image.path);
    }
    return null;
  }

  Future<File?> pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      return File(video.path);
    }
    return null;
  }
}
