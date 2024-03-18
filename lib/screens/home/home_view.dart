import 'package:fifthproject/common_widget/my_list_tile.dart';
import 'package:fifthproject/common_widget/my_pie_chart.dart';
import 'package:fifthproject/core/classes/my_new_api.dart';
import 'package:fifthproject/core/model/expense_data.dart';
import 'package:fifthproject/core/model/productmodel.dart';
import 'package:fifthproject/keys_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import '../../theme.dart';
import 'package:get/get.dart';
import '../settings/settings_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GetStorage getStorage = GetStorage();
  ApiClient _api = ApiClient();
  List? expensesdata;

  Future<List> getExpenses() async {
    print("I'm in getexpenses methos in bottomBarview ");
    var response = await _api.getExpenses();
    expensesdata = response;
    print("the response is ${response}");
    print("the Expensesdata is ${expensesdata}");
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    getExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.gray,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: ListView(children: [
          SafeArea(
            child: Column(
              children: [
                Container(
                  height: media.width * 1.1,
                  decoration: BoxDecoration(
                    color: TColor.gray70.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  //here will be the piechart
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // go to setting page
                            IconButton(
                              onPressed: () {
                                Get.to(() => const SettingsView());
                              },
                              icon: Icon(
                                Icons.settings_sharp,
                                color: TColor.white.withOpacity(0.6),
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                          child: Text("Expenses",
                              style: TextStyle(
                                  color: TColor.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700))),
                      const SizedBox(height: 25),
                      Container(
                          // height: media.width * 0.9,
                          child: Center(child: MyPieChart())),
                    ],
                  ),
                ),

                //////////////////////////////////////////////////////////////////////////////////////

                const SizedBox(height: 20),
                FutureBuilder(
                  future: getExpenses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            var expense = snapshot.data![index];
                            print(
                                "the data is${expense!['time_purchased'].runtimeType} ");
                            String date = expense!['time_purchased'];
                            return MyListTile(
                                type: expense!['expense_name'],
                                title: expense!['item_name'],
                                price: expense!['price'].toString(),
                                date: date.substring(0, 10));
                          }));
                    } else if (snapshot.data!.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Center(
                          child: Text(
                            "No expenses added yet.\nTap the + button to add a new expense.",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 16, color: TColor.gray30),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
