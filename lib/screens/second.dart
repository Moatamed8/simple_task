import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login_with_upload_image/viewmodel/login_provider.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginProvider.of(context,listen: true).file == null ?  SizedBox() :Container(
                  width: 300,
                  height: 300,
                  child: Image.file(LoginProvider.of(context,listen: true).file)) ,
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  LoginProvider.of(context).pickImage();
                },
                child: const Text('Select Image'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async{
                  await LoginProvider.of(context).addProduct();
                },
                child: const Text('Post Image'),
              ),
            ],
          ),
      ),
    );
  }
}
