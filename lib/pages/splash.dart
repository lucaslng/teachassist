import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:teachassist/pages/loadingpage.dart';
import 'package:teachassist/route/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:teachassist/utils/authprovider.dart';
import 'package:teachassist/utils/debug.dart';

@RoutePage()
class SplashPage extends StatefulWidget{
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const _storage = FlutterSecureStorage();

  Future<({String id, String password})>? credentials;

  Future<({String id, String password})> _loadCredentials() async {
      final id = await _storage.read(key: "id");
      final password = await _storage.read(key: "password");
      if (id == null || password == null) {
        final newcreds = await context.router.push<({String id, String password})>(LoginRoute(storage: _storage));
        return newcreds!;
      } else {
        return (id: id, password: password);
      }
      
    }

  @override
  void initState() {
    super.initState();
    credentials = _loadCredentials();
  }

  @override
  Widget build(BuildContext context) {
    var router = AutoRouter.of(context);
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return FutureBuilder(
      future: credentials,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (!authProvider.isLoggedOut) {
            router.push(ScraperSplash(id: snapshot.data!.id, password: snapshot.data!.password));
          } else {
            debug("logout");
            _storage.delete(key: "id");
            _storage.delete(key: "password");
            credentials = _loadCredentials();
          }
        } 
        return const LoadingPage();
      }
    );
    
  }
}