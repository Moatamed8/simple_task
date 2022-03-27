import 'package:flutter/material.dart';
import 'package:login_with_upload_image/helper/expection.dart';
import 'package:login_with_upload_image/screens/second.dart';
import 'package:login_with_upload_image/utils/customFunctions.dart';
import 'package:login_with_upload_image/viewmodel/login_provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _showDialogError(String message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Authentication failed,Please try again"),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(ctx).pop(), child: Text("Okay"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Digital Magna',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () async {
                        final isValid = _formKey.currentState.validate();
                        FocusScope.of(context).unfocus();
                        if (isValid) {
                          _formKey.currentState.save();
                          try {
                            await LoginProvider.of(context, listen: false)
                                .logIn(nameController.text,
                                    passwordController.text);
                            CustomFunctions.pushScreenRepcalement(
                                widget: SecondScreen(), context: context);
                          } on HttpException catch (e) {
                            var errorMessage = 'Authentication failed';
                            if (e.toString().contains('EMAIL_EXISTS')) {
                              errorMessage =
                                  'This email address is already in use';
                            } else if (e.toString().contains('INVALID_EMAIL')) {
                              errorMessage = 'This is not valid email address ';
                            } else if (e
                                .toString()
                                .contains('INVALID_PASSWORD')) {
                              errorMessage = 'This is not valid password  ';
                            } else if (e.toString().contains('WEAK_PASSWORD')) {
                              errorMessage = 'This password is too weak ';
                            } else if (e
                                .toString()
                                .contains('EMAIL_NOT_FOUND')) {
                              errorMessage =
                                  'could not found a user with that email';
                            } else if (e
                                .toString()
                                .contains('INVALID_PASSWORD')) {
                              errorMessage = 'Invalid password ';
                            }
                            _showDialogError(errorMessage);
                          } catch (e) {
                            const errorMessage = '';
                            _showDialogError(errorMessage);
                          }
                        }
                      },
                    )),
              ],
            ),
          )),
    );
  }
}
