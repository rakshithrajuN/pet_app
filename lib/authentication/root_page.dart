import 'package:flutter/material.dart';
import 'package:pet_app/HomeScreen.dart';
import 'login_page.dart';

import 'auth.dart';

AuthStatus authStatus = AuthStatus.notSignedIn;

class RootPage extends StatefulWidget {
  RootPage({Key? key,required this.auth,required this.st}) : super(key: key);
  final BaseAuth auth;
  final String st;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      widget.auth.currentUser().then((email) {
        print(email);
        setState(() {
          if (userId != null) {
           
              authStatus = AuthStatus.signedIn;
            
          } else {
            authStatus = AuthStatus.notSignedIn;
          }
        });
      });
    });
  }

  void _updateAuthStatus(AuthStatus status) {
    if (status != AuthStatus.notSignedIn) {
      widget.auth.currentUser().then((email) {
        print(email);
        setState(() {
         authStatus = AuthStatus.signedIn;
        });
      });
    } else {
      setState(() {
        authStatus = AuthStatus.notSignedIn;
      });
    }
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        {
          return new LoginPage(
            title: ' Login',
            auth: widget.auth,
            type: widget.st,
            onSignIn: () => _updateAuthStatus(AuthStatus.signedIn),
          );
        }
      case AuthStatus.signedIn:
        {
          return new HomeScreen(
              
              auth: widget.auth,
              onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn),
              );
        }
      
    }
  }
}
