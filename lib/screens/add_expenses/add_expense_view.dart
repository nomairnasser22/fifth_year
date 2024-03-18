import 'package:fifthproject/common_widget/primary_button.dart';
import 'package:fifthproject/common_widget/rounded_textField.dart';
import 'package:fifthproject/common_widget/typeDropdownSearch.dart';
import 'package:fifthproject/core/classes/my_new_api.dart';
import 'package:fifthproject/core/classes/stutesrequest.dart';
import 'package:fifthproject/core/function/handlingdata.dart';
import 'package:fifthproject/core/model/productmodel.dart';
import 'package:fifthproject/screens/bottom_bar/bottom_bar_view.dart';
import 'package:fifthproject/screens/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../keys_storage.dart';
import '../../core/model/expense_data.dart';
import '../../core/model/expense_model.dart';
import '../../theme.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  ExpenseData exp = Get.put(ExpenseData());
  TextEditingController nameController = TextEditingController();
  TextEditingController valController = TextEditingController();
  TextEditingController quanitiyController = TextEditingController();
  DateTime date = DateTime.now();
  List<String> items = [
    "Food",
    "EXPENSE_TYPE",
    "Leisure",
    "Cloths",
    "Medicin"
        "Transport",
  ];

  StatusRequest? statusRequest;
  ApiClient _api = ApiClient();
  GetStorage? getStorage = GetStorage();

  ProductModel? expense;
  void clearField() {
    nameController.clear();
    valController.clear();
    quanitiyController.clear();
  }

  Future<void> addExpense() async {
    print("I'm in addExpense method ");
    statusRequest = StatusRequest.loading;

    Map<String, dynamic> expenseData = {
      "item_name": nameController.text,
      "quantity": quanitiyController.text,
      "price": valController.text,
      "expense_type": exp.selectedType
    };
    print('i will sent data to create product methos');
    var response = await _api.createProduct(expenseData);
    print('i recieve data ');
    var right;
    response.fold((l) => expense = l, (r) => right = r);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      print("-------------------the process is successfully------------");
      Get.to(BottomBarView());
    } else if (statusRequest == StatusRequest.loading) {
      CircularProgressIndicator();
    } else if (statusRequest == StatusRequest.serverfailure) {
      print("there is failure server ");
      Text("there is failure server ");
    } else if (statusRequest == StatusRequest.offlinefailure) {
      print("there is offline failure ");
      Text("there is offline failure");
    } else {
      print("the status request is ${statusRequest}");
      Text("something wrong");
    }
  }

  void save() {
    if (nameController.text.isNotEmpty && valController.text.isNotEmpty) {
      ExpenseModel newExpense = ExpenseModel(
          type: exp.selectedType,
          name: nameController.text,
          price: valController.text,
          date: DateTime.now());
      Get.find<ExpenseData>().addExpense(newExpense);
      clearField();
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.gray.withOpacity(0.9),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const SizedBox(height: 10),
                IconButton(
                    onPressed: () {
                      Get.replace(BottomBarView());
                      // Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: TColor.white,
                      size: 30,
                    )),
                Text(
                  "Add Expense",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none),
                ),
                Icon(
                  Icons.spellcheck_rounded,
                  color: TColor.gray70.withOpacity(0.7),
                ),
              ],
            ),
            Stack(alignment: Alignment.center, children: [
              // const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25, top: 20),
                child: Container(
                  alignment: Alignment.topLeft,
                  height: 700,
                  decoration: BoxDecoration(
                      color: TColor.gray70.withOpacity(1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TypeDropDown(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: RoundedTextField(
                          title: "Name",
                          controller: nameController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: RoundedTextField(
                          title: "Price",
                          controller: valController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      // const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: RoundedTextField(
                          title: "quantity",
                          controller: quanitiyController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: PrimaryButton(
                            title: "Add",
                            onPressed: () {
                              addExpense();
                              // save();
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
