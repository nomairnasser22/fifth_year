import 'package:fifthproject/core/classes/my_new_api.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';
import '../add_expenses/add_expense_view.dart';
import '../home/home_view.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({super.key});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  int selectTab = 0;
  ApiClient _api = ApiClient();
  PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTabView = const HomeView();
  List? pieChardata;
  List? expensesdata;
  String? tokrn;

  Future<void> testrefresh() async {
    tokrn = await _api.refreshToken();
  }

  Future<void> initData() async {
    print("I enter to initData method in BottomBarView page ");
    var res = await _api.getPieChart();
    pieChardata = res;
    print("the response from initData method is ${res}");
    print(
        "if you can see me , this means that the request send and you must see the data that is ${pieChardata}");
  }

  Future<void> getExpenses() async {
    print("I'm in getexpenses methos in bottomBarview ");
    var response = await _api.getExpenses();
    expensesdata = response;
    print("the response is ${response}");
    print("the Expensesdata is ${expensesdata}");
  }

  @override
  void initState() {
    // TODO: implement initState
    // initData();
    getExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.gray,
      body: Stack(
        children: [
          PageStorage(
            bucket: pageStorageBucket,
            child: currentTabView,
          ),
          Column(
            children: [
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      Image.asset("assets/img/bottom_bar_bg.png"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // go to home page
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selectTab = 0;
                                currentTabView = const HomeView();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => HomeView()));
                              });
                            },
                            icon: Icon(
                              Icons.home,
                              size: 30,
                              color:
                                  selectTab == 0 ? TColor.white : TColor.gray30,
                            ),
                          ),
                          //go to barChart page
                          IconButton(
                            onPressed: () {
                              testrefresh();
                              // initData();
                              // setState(() {
                              //   selectTab = 1;
                              //   currentTabView = Container();
                              // });
                            },
                            icon: Icon(
                              Icons.bar_chart_sharp,
                              size: 30,
                              color:
                                  selectTab == 1 ? TColor.white : TColor.gray30,
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                            height: 50,
                          ),
                          //go to note page
                          IconButton(
                            onPressed: () {
                              // getExpenses();
                              // initData();
                              setState(() {
                                selectTab = 2;
                                currentTabView = Container();
                              });
                            },
                            icon: Icon(
                              Icons.note,
                              size: 30,
                              color:
                                  selectTab == 2 ? TColor.white : TColor.gray30,
                            ),
                          ),
                          //go to profile page
                          IconButton(
                            onPressed: () {
                              // getExpenses();
                              setState(() {
                                selectTab = 3;
                                currentTabView = Container();
                              });
                            },
                            icon: Icon(
                              Icons.abc,
                              size: 30,
                              color:
                                  selectTab == 3 ? TColor.white : TColor.gray30,
                            ),
                          ),
                        ],
                      ),
                    ]),
                    // go to add product page
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddExpenseView()));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: TColor.secondary.withOpacity(0.5),
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          "assets/img/center_btn.png",
                          width: 55,
                          height: 55,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
