import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vp18_api_app/api/controller/auth_api_controller.dart';
import 'package:vp18_api_app/api/models/process_response.dart';
import 'package:vp18_api_app/utils/context_extension.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;

  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsDirectional.only(start: 30, top: 100, end: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
                style: GoogleFonts.nunito(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Login to start using app",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF716F87),
                ),
              ),
              const SizedBox(height: 37),
              TextField(
                controller: _emailTextController,
                maxLines: 1,
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.send,
                cursorColor: Colors.black,
                cursorHeight: 30,
                cursorWidth: 1,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintMaxLines: 1,
                  errorText: _emailError,
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _passwordTextController,
                maxLines: 1,
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.send,
                cursorColor: Colors.black,
                cursorHeight: 30,
                cursorWidth: 1,
                obscureText: _obscure,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintMaxLines: 1,
                  errorText: _passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() => _obscure = !_obscure);
                    },
                    color: Colors.grey,
                  ),
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () => _performLogin(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF6A90F2),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  minimumSize: const Size(double.infinity, 53),
                ),
                child: const Text(
                  "Login",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF716F87),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/register_screen'),
                    child: Text(
                      "Create Now!",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performLogin() {
    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    _controlErrors();
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: "Insert required data", erorr: true);
    return false;
  }

  void _controlErrors() {}

  void _login() async {
    ProcessResponse processResponse = await AuthApiController()
        .login(_emailTextController.text, _passwordTextController.text);
    if (processResponse.success) {
      Navigator.pushReplacementNamed(context, '/users_screen');
    }
    context.showSnackBar(message: processResponse.message, erorr: !processResponse.success);
  }
}
