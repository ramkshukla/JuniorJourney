import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_overflow/_util/common_function.dart';
import 'package:stack_overflow/module/home/controller/home_controller.dart';
import 'package:stack_overflow/module/home/controller/home_event.dart';
import 'package:stack_overflow/module/home/controller/home_state.dart';
import 'package:stack_overflow/module/tut_coach.dart';
import 'package:stack_overflow/my_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
  }

  @override
  void didPush() {
    print("Home Screen Push called>>>>>");
    super.didPush();
  }

  @override
  void didPop() {
    print("Home Screen pop called>>>>>");
    super.didPop();
  }

  @override
  void didPopNext() {
    print("Home Screen pop Next called>>>>>");
    super.didPopNext();
  }

  @override
  void didPushNext() {
    print('Page1: Called didPushNext');
    super.didPushNext();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Tabs
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20),
                  right: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<HomeBloc>().add(ActiveTab(value: true));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: state.balanceTab
                            ? Colors.blue.withOpacity(0.5)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        "Balance",
                        style: TextStyle(
                          color: state.balanceTab ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      context.read<HomeBloc>().add(ActiveTab(value: false));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: state.walletTab
                            ? Colors.blue.withOpacity(0.5)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        "Wallet",
                        style: TextStyle(
                          color: state.walletTab ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Total Balance
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyTutorialCoach(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, bottom: 30, right: 20),
                padding: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16)),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Total balance\n",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextSpan(
                        text: "200, 000 FCFA",
                        style: TextStyle(fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                  data.length,
                  (index) => Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(right: 12),
                        decoration: ShapeDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          shape: CircleBorder(),
                        ),
                        child: Icon(data[index].iconData),
                      ),
                      SizedBox(height: 4),
                      Text(
                        data[index].text,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledForegroundColor: null,
                  foregroundColor: null,
                  splashFactory: null,
                  surfaceTintColor: null,
                  disabledBackgroundColor: null,
                  shadowColor: null,
                  visualDensity: VisualDensity.comfortable,
                ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.message),
                    SizedBox(width: 8),
                    Text("Perform an operation"),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TRANSACTIONS",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "See More",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.blue.withOpacity(0.4),
                            ),
                            child: Icon(Icons.arrow_downward),
                          ),
                          SizedBox(width: 18),
                          Column(
                            children: [
                              Text("Spotify Subscription"),
                              Text("22 July 2021")
                            ],
                          )
                        ],
                      ),
                      Text("15,000FCFA", style: TextStyle(color: Colors.red))
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey.withOpacity(0.3),
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
