import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _textController1;
  late TextEditingController _textController2;
  late TextEditingController _textController3;
  late TextEditingController _textController4;

  late FocusNode _textFieldFocusNode1;
  late FocusNode _textFieldFocusNode2;
  late FocusNode _textFieldFocusNode3;
  late FocusNode _textFieldFocusNode4;

  @override
  void initState() {
    super.initState();

    _textController1 = TextEditingController();
    _textController2 = TextEditingController();
    _textController3 = TextEditingController();
    _textController4 = TextEditingController();

    _textFieldFocusNode1 = FocusNode();
    _textFieldFocusNode2 = FocusNode();
    _textFieldFocusNode3 = FocusNode();
    _textFieldFocusNode4 = FocusNode();
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    _textController4.dispose();

    _textFieldFocusNode1.dispose();
    _textFieldFocusNode2.dispose();
    _textFieldFocusNode3.dispose();
    _textFieldFocusNode4.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 7,
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
                      buildInputField('Nombre', _textController1, _textFieldFocusNode1, 'Nombre Completo', Icons.person),
                      buildInputField('Nickname', _textController2, _textFieldFocusNode2, 'Nickname', Icons.alternate_email),
                      buildInputField('Correo', _textController3, _textFieldFocusNode3, 'Correo', Icons.alternate_email),
                      buildInputField('Contraseña', _textController4, _textFieldFocusNode4, 'Contraseña', Icons.lock_open_rounded),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFBF5D5D),
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          fixedSize: Size.fromHeight(51),
                        ),
                        child: Text(
                          'Button',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 16,
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
    );
  }

  Widget buildInputField(String label, TextEditingController controller, FocusNode focusNode, String hintText, IconData prefixIcon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        obscureText: label == 'Contraseña',
        decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
          prefixIcon: Icon(prefixIcon),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFE0E3E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFBF5D5D),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).errorColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Color(0xFFE0E3E7),
        ),
        style: TextStyle(
          fontSize: 16,
          height: 1,
        ),
        // Add your validator function here
      ),
    );
  }
}
