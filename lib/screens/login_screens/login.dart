import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopzilla/components/buttons/button.dart';
import 'package:shopzilla/components/input_fields/custom_text_input.dart';
import 'package:shopzilla/components/buttons/small_button.dart';
import 'package:shopzilla/screens/login_screens/forgot_pw.dart';
import 'package:shopzilla/utils/app_state.dart';
import 'package:shopzilla/utils/custom_theme.dart';
import 'package:shopzilla/components/other_widgets/login_background.dart';

final formKey = GlobalKey<FormState>();

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with AutomaticKeepAliveClientMixin {
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController pwCon = TextEditingController();

  bool loading = false;
  Map<String, String> data = LoginData.signIn;

  void switchLogin() {
    setState(() {
      if (mapEquals(data, LoginData.signUp)) {
        data = LoginData.signIn;
      } else {
        data = LoginData.signUp;
      }
    });
  }

  loginError(FirebaseAuthException e) {
    if (e.message != '') {
      setState(() {
        loading = false;
      });
    }
  }

  Future loginButton() async {
    setState(() {
      loading = true;
    });

    if (mapEquals(data, LoginData.signUp)) {
      AppState.signUp(emailCon.text.trim(), pwCon.text.trim(), loginError);
    } else {
      AppState.signIn(emailCon.text.trim(), pwCon.text.trim(), loginError);
    }
  }

  @override
  void dispose() {
    emailCon.dispose();
    pwCon.dispose();

    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: BackGround(
          first: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20.0,
                    left: 15,
                  ),
                  child: Text(
                    data['heading'] as String,
                    style: GoogleFonts.charmonman(
                        shadows: const [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 18,
                              spreadRadius: 2)
                        ],
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      model(data, emailCon, pwCon),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['footer'] as String,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(width: 5),
                          SmallButton(
                            text: data['label'] as String == "SIGN UP"
                                ? "SIGN IN"
                                : "SIGN UP",
                            onPressed: switchLogin,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          second: Positioned(
            left: 50,
            bottom: 8,
            right: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Made in Bharat ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                    width: 22,
                    height: 15,
                    color: Colors.white,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://i.ibb.co/5vWCWH5/india-flag-logo-3522-C6780-F-seeklogo-com.png',
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          ),
        ));
  }

  model(Map<String, String> data, TextEditingController emailCon,
      TextEditingController pwCon) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 0),
        decoration: CustomTheme.logInCardDecor(),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextInput(
                      label: 'Your email address :',
                      icon: Icons.person_outline,
                      placeHolder: 'email123@gmail.com',
                      textCon: emailCon),
                  CustomTextInput(
                      label: 'Password :',
                      icon: Icons.person_outline,
                      placeHolder: 'password',
                      password: true,
                      textCon: pwCon),
                  Button(
                      text: '${data['label']}',
                      onPress: loginButton,
                      color: CustomTheme.yellow
                      //const Color.fromARGB(255, 189, 224, 238),
                      ),
                  data['label'] == 'SIGN IN'
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ForgotPw()));
                            },
                            child: const Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white),
                            ),
                          ),
                        )
                      : Column(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
