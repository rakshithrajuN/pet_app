import 'package:flutter/material.dart';
import 'authentication/auth.dart';
import 'authentication/root_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

<<<<<<< HEAD
import 'DrawerScreen.dart';
import 'HomeScreen.dart';

void main() async{
=======
void main() async {
>>>>>>> a3782376d0e6e774699dd53e29978a0fb47e22da
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
   await FirbaseAppCheck.instance.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodCourt',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: RootPage(
        auth: new Auth(),
        st: 'Register',
      ),
    );
  }
}
