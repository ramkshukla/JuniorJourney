import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:junior_journey/NewPage.dart';
import 'package:junior_journey/config/constant.dart';
import 'package:junior_journey/data/dummy.dart';
import 'package:junior_journey/data/my_colors.dart';
import 'package:junior_journey/data/my_text.dart';
import 'package:junior_journey/model/bottom_nav.dart';
import 'package:junior_journey/model/category.dart';
import 'package:junior_journey/screen/alphabet_main.dart';
import 'package:junior_journey/screen/splash_screen.dart';

void main() {
  "Main Method is called".logIt;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class BottomNavigationShop extends StatefulWidget {
  const BottomNavigationShop({super.key});

  @override
  BottomNavigationIconRouteState createState() =>
      BottomNavigationIconRouteState();
}

class BottomNavigationIconRouteState extends State<BottomNavigationShop>
    with SingleTickerProviderStateMixin {
  int currentIndex = 1;
  late BuildContext ctx;
  final List<BottomNav> itemsNav = <BottomNav>[
    BottomNav('Home', Icons.home, null),
    BottomNav('Account', Icons.person, null),
    BottomNav('Settings', Icons.settings, null),
    BottomNav('Share', Icons.share, null),
  ];

  void onBackPress() {
    if (Navigator.of(ctx).canPop()) {
      Navigator.of(ctx).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    // Start the automatic progression
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitDown,
    //   DeviceOrientation.portraitUp,
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;

    List<ShopCategory> listCategory = Dummy.getShoppingCategory();
    List<Widget> gridCategory = getGridViewCategory(listCategory);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: MyColors.green_100_,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        title: const Text("Junior Journey"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/green_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 200,
                          decoration: const BoxDecoration(color: Colors.blue),
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/panda_.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.4),
                          height: 200,
                          width: double.infinity,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                      child: Column(
                        children: gridCategory,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MyColors.primary,
        unselectedItemColor: Colors.grey[400],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: itemsNav.map((BottomNav d) {
          return BottomNavigationBarItem(
            icon: Icon(d.icon),
            label: d.title,
          );
        }).toList(),
      ),
    );
  }

  List<Widget> getGridViewCategory(List<ShopCategory> lc) {
    List<Widget> wc = [];
    for (int i = 0; i < lc.length / 2; i++) {
      Widget w;
      w = Row(
        children: <Widget>[
          getItemViewGrid(lc[i * 2]),
          Container(width: 2),
          getItemViewGrid(lc[(i * 2) + 1])
        ],
      );

      wc.add(w);
    }
    return wc;
  }

  Widget getItemViewGrid(ShopCategory s) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            String name = s.title;
            if (name == "Fashion") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AlphabetMain()),
              );
            } else if (name == "Home and Garden") {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewPage(title: s.title)),
              );
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            color: MyColors.green_215_,
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              height: 120,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Icon(s.icon, size: 40, color: Colors.grey[600]),
                  ),
                  Text(s.title,
                      textAlign: TextAlign.center,
                      style: MyText.subhead(context)!
                          .copyWith(color: Colors.grey[800])),
                ],
              ),
            ),
          ),
        ));
  }
}
