import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'objectbox.dart';
import 'homeScreen.dart';
/// Provides access to the ObjectBox Store throughout the app.
late ObjectBox objectbox;

Future<void> main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();

  runApp(MyApp());
}
const primaryTextColor = Color(0xff1D2830);
const Color primaryColor = Color(0xff794CFF);
const Color primaryVariantColor = Color(0xff5C0AFF);
const secondaryTextColor = Color(0xffAFBED0);
const normalPriority = Color(0xffF09819);
const lowPriority = Color(0xff3BE1F1);
const highPriority = primaryColor;


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDO',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(const TextTheme(
              headline6: TextStyle(fontWeight: FontWeight.bold))),
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
              primary: primaryColor,
              primaryContainer: primaryVariantColor,
              background: Color(0xffF3F5F8),
              onSurface: primaryTextColor,
              onPrimary: Colors.white,
              onBackground: primaryTextColor,
              secondary: primaryColor,
              onSecondary: Colors.white)
      ),
      home: const HomeScreen(),
    );
  }
}


