import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopzilla/components/models/custom_search_delegate.dart';
import 'package:shopzilla/screens/tab_screens/checkout.dart';
import 'package:shopzilla/screens/tab_screens/favourite.dart';
import 'package:shopzilla/screens/tab_screens/home.dart';
import 'package:shopzilla/screens/tab_screens/profile.dart';
import 'package:shopzilla/utils/app_state.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  PageController pageCon = PageController(initialPage: 0);

  @override
  void initState() {
    setState(() {
      AppState.getDetails();
    });

    super.initState();
  }

  @override
  void dispose() {
    pageCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[100],
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              //billabong,Brush Script, lobster,pacifico

              backgroundColor: Colors.black.withOpacity(.95),
              surfaceTintColor: Colors.black,

              elevation: 50,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              shadowColor: Colors.black12,
              title: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: Text('Roadster',
                    style: GoogleFonts.charmonman(
                        //tangerine
                        shadows: const [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 6,
                              spreadRadius: 2,
                              blurStyle: BlurStyle.inner)
                        ],
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1)),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: CustomSearchDelegate());
                    },
                    iconSize: 28,
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              child: DefaultTextStyle(
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w200,
                  fontSize: 15,
                ),
                child: FlashyTabBar(
                  height: 55,
                  backgroundColor: Colors.black,
                  selectedIndex: selectedIndex,
                  iconSize: 26,
                  onItemSelected: (index) {
                    setState(() {
                      pageCon.jumpToPage(index);
                      selectedIndex = index;
                    });
                  },
                  items: [
                    FlashyTabBarItem(
                      icon: const Icon(Icons.home),
                      activeColor: Colors.white,
                      inactiveColor: Colors.white54,
                      title: const Text(
                        'Home',
                      ),
                    ),
                    FlashyTabBarItem(
                      icon: const Icon(Icons.shopping_cart),
                      activeColor: Colors.white,
                      inactiveColor: Colors.white54,
                      title: const Text('Cart'),
                    ),
                    FlashyTabBarItem(
                      icon: const Icon(Icons.favorite),
                      activeColor: Colors.white,
                      inactiveColor: Colors.white54,
                      title: const Text('Fav'),
                    ),
                    FlashyTabBarItem(
                      icon: const Icon(Icons.person),
                      activeColor: Colors.white,
                      inactiveColor: Colors.white54,
                      title: const Text('Profile'),
                    ),
                  ],
                ),
              ),
            ),
            body: PageView(
              controller: pageCon,
              allowImplicitScrolling: true,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              children: const [
                Home(),
                CheckOut(),
                Favourite(),
                Profile(),
              ],
            )));
  }
}
