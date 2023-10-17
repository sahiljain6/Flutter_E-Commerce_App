import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopzilla/components/buttons/button.dart';
import 'package:shopzilla/components/other_widgets/detail.dart';
import 'package:shopzilla/components/input_fields/profile_input.dart';
import 'package:shopzilla/components/buttons/small_button.dart';
import 'package:shopzilla/screens/order_history.dart';
import 'package:shopzilla/screens/reset._password.dart';
import 'package:shopzilla/utils/app_state.dart';

final formKey3 = GlobalKey<FormState>();

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool button = false;
  final TextEditingController _nameCon =
      TextEditingController(text: AppState.details[0]);
  final TextEditingController _mobileCon =
      TextEditingController(text: AppState.details[1]);
  final TextEditingController _addressCon =
      TextEditingController(text: AppState.details[2]);
  final TextEditingController _cityCon =
      TextEditingController(text: AppState.details[3]);
  final TextEditingController _pinCodeCon =
      TextEditingController(text: AppState.details[4]);

  void reset() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const Reset(),
    ));
  }

  @override
  void dispose() {
    _nameCon.dispose();
    _mobileCon.dispose();
    _addressCon.dispose();
    _cityCon.dispose();
    _pinCodeCon.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          color: Colors.black,
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 55,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person, size: 35, color: Colors.white),
                    Text('User Details',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5.0, left: 25, right: 25),
                child: Divider(
                  color: Colors.white,
                  thickness: .4,
                ),
              ),
              button ? form() : detailCard(),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                child: Button(
                    onPress: () async {
                      if (!button) {
                        var pref = await SharedPreferences.getInstance();
                        pref.setStringList('details', [
                          _nameCon.text,
                          _mobileCon.text,
                          _addressCon.text,
                          _cityCon.text,
                          _pinCodeCon.text
                        ]);

                        AppState.details = pref.getStringList('details') ?? [];
                      }

                      setState(() {
                        button = !button;
                      });
                    },
                    shadowColor: Colors.transparent,
                    splashColor: Colors.white,
                    text: button ? 'SAVE CHANGES' : 'UPDATE',
                    color: Colors.white.withOpacity(0.9)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: button
                    ? SmallButton(
                        text: 'Change Password',
                        onPressed: () {
                          reset();
                        })
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallButton(
                              text: 'Sign Out',
                              onPressed: () {
                                AppState.signOut();
                              }),
                          SmallButton(
                              text: 'Orders History',
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const OrderHistory(),
                                ));
                              }),
                        ],
                      ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  detailCard() {
    return Container(
      padding: const EdgeInsets.all(1.25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.cyan, Colors.black, Colors.cyan])),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black, Colors.black.withOpacity(0.82)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Detail(title: 'Username :  ', value: AppState.details[0]),
              Detail(
                  title: 'Mobile no. :  ',
                  mobile: true,
                  value: AppState.details[1]),
              Detail(
                  title: 'Email id :  ',
                  value: FirebaseAuth.instance.currentUser!.email!),
              Detail(title: 'Address  :  ', value: AppState.details[2]),
              Detail(title: 'City :  ', value: AppState.details[3]),
              Detail(title: 'PinCode :  ', value: AppState.details[4]),
            ],
          ),
        ),
      ),
    );
  }

  form() {
    return Form(
        key: formKey3,
        autovalidateMode: AutovalidateMode.always,
        child: Column(children: [
          ProfileInput(label: 'Username :  ', textCon: _nameCon),
          ProfileInput(label: 'Mobile no. :  ', textCon: _mobileCon),
          ProfileInput(label: 'Address  :  ', textCon: _addressCon),
          ProfileInput(label: 'City :  ', textCon: _cityCon),
          ProfileInput(label: 'PinCode :  ', textCon: _pinCodeCon),
        ]));
  }
}
