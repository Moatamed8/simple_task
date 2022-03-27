import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_with_upload_image/utils/TokenUtil.dart';
import 'package:login_with_upload_image/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {
  static LoginProvider of(BuildContext context, {bool listen = false}) {
    if (listen) return context.watch<LoginProvider>();
    return context.read<LoginProvider>();
  }

  bool isLoading = false;
  File file;
  MultipartFile imagePost;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=${Constants.apiKey}';
    try {
      isLoading = true;
      final res = await http.post(Uri.parse(url),
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = jsonDecode(res.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      TokenUtil.saveToken(responseData['idToken']);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      throw e;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> logIn(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<File> pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      file = File(pickedFile.path);
      final String fileName = pickedFile.path.split('/').last;
      notifyListeners();
    } else {
      return null;
    }
  }

  Future<void> addProduct() async {
    final url =
        'https://shopflutterapp-9b1c3-default-rtdb.firebaseio.com/products.json?auth=${Constants.token}';

    try {
      final res = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'imageUrl': base64Encode(file.readAsBytesSync()),
        }),
      );

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
