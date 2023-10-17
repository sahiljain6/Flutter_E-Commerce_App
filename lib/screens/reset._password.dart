import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopzilla/components/input_fields/profile_input.dart';
import 'package:shopzilla/components/buttons/small_button.dart';
import 'package:shopzilla/screens/login_screens/login.dart';
import 'package:shopzilla/utils/app_state.dart';

class Reset extends StatefulWidget {
  const Reset({
    super.key,
  });

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  final TextEditingController oldPw = TextEditingController();
  final TextEditingController newPw = TextEditingController();
  final TextEditingController newPw2 = TextEditingController();

  void resetPw() async {
    final user = FirebaseAuth.instance.currentUser!;
    var pref = await SharedPreferences.getInstance();
    String p = pref.getString('pw')!;

    if (oldPw.text.trim() == p &&
        p != '' &&
        newPw2.text.trim() == newPw.text.trim()) {
      user.updatePassword(newPw.text.trim());
      AppState.storePw(newPw.text.trim());

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      final warning = SnackBar(
          backgroundColor: Colors.black,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Password changed !',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w100,
                          fontSize: 12,
                        ),
                      ))
                ],
              ),
            ],
          ));
      messengerKey.currentState!
        ..removeCurrentSnackBar()
        ..showSnackBar(warning);
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
            backgroundColor: Colors.black,
            shape: StadiumBorder(),
            title: Center(
                child: Text(
              'Wrong Info. !',
              style: TextStyle(color: Colors.red),
            ))),
      );
    }
  }

  @override
  void dispose() {
    oldPw.dispose();
    newPw.dispose();
    newPw2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Reset Password',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white, fontSize: 18)),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 80),
          child: pwForm()),
    );
  }

  pwForm() {
    return Column(children: [
      Form(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        ProfileInput(label: 'Current Password :  ', textCon: oldPw),
        ProfileInput(label: 'New Password :  ', textCon: newPw),
        ProfileInput(label: 'Confirm New Password  :  ', textCon: newPw2),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SmallButton(text: 'Update', onPressed: resetPw),
        )
      ]))
    ]);
  }
}
