// views/register_view.dart
import 'dart:io';
import 'dart:ui';
import 'package:fittrack/res/components/input_field.dart'; // Importa el nuevo widget InputField
import 'package:fittrack/res/components/password_field.dart'; // Importa el PasswordField
import 'package:fittrack/utils/utils.dart';
import 'package:fittrack/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _fullNameController;
  late TextEditingController _nicknameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late FocusNode fullNameFocusNode;
  late FocusNode nicknameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();

    _fullNameController = TextEditingController();
    _nicknameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    fullNameFocusNode = FocusNode();
    nicknameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    fullNameFocusNode.dispose();
    nicknameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              alignment: AlignmentDirectional(0.25, 0.00),
              image: NetworkImage(
                'https://www.meritain.com/wp-content/uploads/2021/06/Image_2021-Healthy-home-cooked-meals.jpg',
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4,
                  sigmaY: 4,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.0,
                  decoration: BoxDecoration(
                    color: Color(0x83C1AC9C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Regístrate',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Haz tus primeros pasos',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        InputField(label: 'Nombre', controller: _fullNameController, focusNode: fullNameFocusNode),
                        InputField(label: 'Nickname', controller: _nicknameController, focusNode: nicknameFocusNode),
                        InputField(label: 'Correo', controller: _emailController, focusNode: emailFocusNode),
                        PasswordField(controller: _passwordController, focusNode: passwordFocusNode),
                        SizedBox(height: 20),
                        ElevatedButton(
                          child: Text(
                            'Regístrate',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFBF5D5D),
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            fixedSize: Size.fromHeight(51),
                          ),
                          onPressed: () {
                            if (_fullNameController.text.isEmpty) {
                              Utils.flushBarErrorMessage(
                                "Introduce tu nombre completo",
                                context,
                              );
                            } else if (_nicknameController.text.isEmpty) {
                              Utils.flushBarErrorMessage(
                                "Introduce un nickname",
                                context,
                              );
                            } else if (_emailController.text.isEmpty) {
                              Utils.flushBarErrorMessage(
                                "Introduce tu correo",
                                context,
                              );
                            } else if (_passwordController.text.isEmpty) {
                              Utils.flushBarErrorMessage(
                                "Introduce una contraseña",
                                context,
                              );
                            } else if (_passwordController.text.length < 6) {
                              Utils.flushBarErrorMessage(
                                "Introduce una contraseña válida",
                                context,
                              );
                            } else {
                              Map data = {
                                "nombre": _fullNameController.text.toString(),
                                "nickname": _nicknameController.text.toString(),
                                "contrasenya": _passwordController.text.toString(),
                                "email": _emailController.text.toString(),
                              };
                              print("EEEEEEEEEEEEEEEE" + data.toString());
                              authViewModel.registerApi(data, context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
