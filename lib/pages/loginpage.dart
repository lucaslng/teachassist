import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:teachassist/main.dart';
import 'package:teachassist/pages/homepage.dart';
import 'package:teachassist/utils/debug.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  var _passwordView = true;
  final _storage = const FlutterSecureStorage();
  var _id = "";
  var _password = "";

  Future<void> login(String id, String password) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomePage(id: id, password: password);
        }
      )
    );
  }

  Future<void> _loadCredentials() async {
    final id = await _storage.read(key: "id");
    final password = await _storage.read(key: "password");
    setState(() {
      _id = id ?? "";
      _password = password ?? "";
    });
  }

  Future<void> _setCredentials(String id, String password) async {
    setState(() {
      _storage.write(key: "id", value: id);
      _storage.write(key: "password", value: password);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    appState.id = _id;
    appState.password = _password;

    Widget loginForm = Scaffold(
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text("$_id\n$_password"),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _idController,
                      decoration: InputDecoration(
                        hintText: "Student ID",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: InputBorder.none,
                        errorStyle: theme.textTheme.labelSmall!.copyWith(color: theme.colorScheme.error),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a student ID";
                        }
                        if (value.contains(RegExp("[^0-9]"))) {
                          return "Please enter a valid student ID";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _passwordController,
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: _passwordView,
                      decoration: InputDecoration(
                        hintText: "Password",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: InputBorder.none,
                        suffixStyle: theme.primaryTextTheme.displaySmall,
                        suffixIcon: IconButton(
                          icon: _passwordView ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                          onPressed:() {
                            setState(() {
                              _passwordView = !_passwordView;
                            });
                          },
                        )
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a password";
                        }
                        if (value.contains(RegExp("[^0-9a-z]"))) {
                          return "Please enter a valid password";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  label: const Text("Login"),
                  icon: const Icon(Icons.login),
                  onPressed:() {
                    if (_formKey.currentState!.validate()) {
                      debug("username: ${_idController.text}");
                      debug("password: ${_passwordController.text}");
                      _setCredentials(_idController.text, _passwordController.text);
                      appState.id = _idController.text;
                      appState.password = _passwordController.text;
                      login(_idController.text, _passwordController.text);
                    }
                  },
                )
              ]
            ),
          )
        )
      );
    
    return Builder(builder: (context) {
      if (mounted && _id != "" && _password != "") {
        Future.microtask(() => login(_id, _password));
        debug("logging in with $_id, $_password");
      }
      return loginForm;
    });
  }
}

