

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fittrack/res/components/round_button.dart';
import 'package:fittrack/utils/utils.dart';
import 'package:fittrack/view_model/auth_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(false);

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode nicknameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  
  
 
  @override 
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Regístrate"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  hintText: "Nombre Completo",
                  labelText: "Nombre Completo",
                  prefixIcon: Icon(Icons.person),
                ),
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(
                    context,
                    fullNameFocusNode,
                    nicknameFocusNode,
                  );
                },
              ),
              TextFormField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  hintText: "Nickname",
                  labelText: "Nickname",
                  prefixIcon: Icon(Icons.alternate_email),
                ),
                focusNode: nicknameFocusNode,
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(
                    context,
                    nicknameFocusNode,
                    emailFocusNode,
                  );
                },
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: const InputDecoration(
                  hintText: "Correo",
                  labelText: "Correo",
                  prefixIcon: Icon(Icons.alternate_email),
                ),
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(
                    context,
                    emailFocusNode,
                    passwordFocusNode,
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: _obscurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword.value,
                    decoration: InputDecoration(
                      hintText: "Contraseña",
                      labelText: "Contraseña",
                      prefixIcon: Icon(Icons.lock_open_rounded),
                      suffixIcon: InkWell(
                        onTap: () {
                          _obscurePassword.value = !_obscurePassword.value;
                        },
                        child: Icon(_obscurePassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility),
                      ),
                    ),
                    focusNode: passwordFocusNode,
                  );
                },
              ),
              SizedBox(
                height: height * 0.085,
              ),
              RoundButton(
                title: "Registrarse",
                loading: authViewModel.loading,
                onPress: () {
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
              SizedBox(height: height * 0.02),
              if (!(Platform.isWindows || Platform.isMacOS || Platform.isLinux))
                InkWell(child: Text("¿Ya tienes una cuenta? Inicia sesión")),
            ],
          ),
        ),
      ),
    );
  }
}
