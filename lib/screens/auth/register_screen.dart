import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vp18_api_app/api/controller/auth_api_controller.dart';
import 'package:vp18_api_app/api/models/process_response.dart';
import 'package:vp18_api_app/api/models/student.dart';
import 'package:vp18_api_app/utils/context_extension.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscure = true;

  late TextEditingController _fullNameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  String? _fullNameError;
  String? _emailError;
  String? _passwordError;

  final String _gender = 'M';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 25),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(start: 30, end: 30, top: 60),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sing in",
                style: GoogleFonts.nunito(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Create Account",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF716F87),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _fullNameTextController,
                maxLines: 1,
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.send,
                cursorColor: Colors.black,
                cursorHeight: 30,
                cursorWidth: 1,
                decoration: InputDecoration(
                  hintText: "Full Name",
                  hintMaxLines: 1,
                  errorText: _fullNameError,
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
              const SizedBox(height: 18),
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
              const SizedBox(height: 18),
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
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _performRegister(),
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
                child: const Text("Sign In"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performRegister() async {
    if (_checkData()) {
      await _register();
    }
  }

  bool _checkData() {
    _controlErrors();
    if (_fullNameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(
        message: "Insert required data", erorr: true);
    return false;
  }

  void _controlErrors() {}

  Future<void> _register() async {
    ProcessResponse processResponse = await AuthApiController()
        .register(student);
    if (processResponse.success) {
      // Navigator.pushReplacementNamed(context, '/login_screen');
      Navigator.pop(context);
    }
    context.showSnackBar(message: processResponse.message, erorr: !processResponse.success);
  }

  Student get student {
    Student student = Student();
    student.email = _emailTextController.text;
    student.password = _passwordTextController.text;
    student.fullName = _fullNameTextController.text;
    student.gender = _gender;
    return student;
  }
}
