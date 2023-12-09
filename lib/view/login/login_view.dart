// login_view.dart
import 'dart:io';
import 'dart:ui';
import 'package:fittrack/models/usuario/login_usuario_model.dart';
import 'package:fittrack/res/components/input_field.dart'; 
import 'package:fittrack/res/components/password_field.dart'; 
import 'package:fittrack/utils/routes/routes_name.dart';
import 'package:fittrack/utils/utils.dart';
import 'package:fittrack/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obscurePassword.dispose();
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
                  height: MediaQuery.of(context).size.height / 2.5,
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
                          'Inicia sesión',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        InputField(label: 'Correo',controller: _emailController,focusNode: emailFocusNode,),
                        PasswordField(controller: _passwordController,focusNode: passwordFocusNode),
                        SizedBox(height: 20),
                        ElevatedButton(
                          child: Text(
                            'Login',
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
                            if (_emailController.text.isEmpty) {
                              Utils.flushBarErrorMessage(
                                'Introduce tu correo',
                                context,
                              );
                            } else if (_passwordController.text.isEmpty) {
                              Utils.flushBarErrorMessage(
                                'Introduce una contraseña',
                                context,
                              );
                            } else if (_passwordController.text.length < 6) {
                              Utils.flushBarErrorMessage(
                                'Introduce una contraseña válida',
                                context,
                              );
                            } else {
                              final loginUser = LoginUsuarioModel(
                                email: _emailController.text.toString(),
                                contrasenya: _passwordController.text.toString(),
                              );

                              authViewModel.loginApi(loginUser, context);
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        if (!(Platform.isWindows ||
                            Platform.isMacOS ||
                            Platform.isLinux))
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutesName.register);
                            },
                            child: Text(
                              '¿No tienes cuenta? Regístrate',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
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
