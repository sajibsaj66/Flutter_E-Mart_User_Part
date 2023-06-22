import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //? So that all the widgets run once
  await Firebase.initializeApp();
  //? Because of this, the MyApp will not run untill Firebase is started
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //? we are using getx, so we have to change it to GetMaterialApp
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: appname,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.transparent,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(
                  color: darkFontGrey,
                )),
            fontFamily: regular),
        home: SplashScreen());
  }
}
