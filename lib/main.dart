import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopzilla/screens/login_screens/email_verify.dart';
import 'package:shopzilla/screens/login_screens/login.dart';

final HideNavbar hiding = HideNavbar();

final theme = ThemeData(
  useMaterial3: true,
  chipTheme: const ChipThemeData(
    showCheckmark: false,
  ),
  canvasColor: Colors.transparent,
  textTheme: TextTheme(
    headlineMedium: const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18),
    headlineSmall: const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
    bodyLarge: GoogleFonts.montserrat(
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.montserrat(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.montserrat(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: messengerKey,
      theme: theme,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Verify();
          } else {
            return const Login();
          }
        },
      ),
    ),
  ));
}

class HideNavbar {
  ValueNotifier<bool> visible = ValueNotifier<bool>(true);

  /*HideNavbar() {
    visible.value = true;

    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (visible.value) {
          visible.value = false;
        }
      } else if (controller.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!visible.value) {
          visible.value = true;
        }
      }
    });
  }*/

  void dispose() {
    visible.dispose();
  }
}
