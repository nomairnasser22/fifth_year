import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/model/expense_data.dart';
import '../theme.dart';

class TypeDropDown extends StatefulWidget {
  const TypeDropDown({super.key});

  @override
  State<TypeDropDown> createState() => _TypeDropDownState();
}

class _TypeDropDownState extends State<TypeDropDown> {
  // List<String> items = [
  //   "Food",
  //   "Drinks",
  //   "Entertainment",
  //   "Education",
  //   "Other"
  // ];
  List<String> items2 = [
    "Food",
    "Leisure",
    // "House & Renovation",
    "Cloths",
    "Medicin",
    "Transport",
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      onChanged: (value) {
        if (value != null) {
          Get.find<ExpenseData>().updateSelectedExpenseType(value);
        }
      },
      popupProps: PopupProps.menu(
        itemBuilder: (context, item, isSelected) {
          IconData icon;
          switch (item) {
            case "Food":
              icon = Icons.fastfood;
              break;
            case "Cloths":
              icon = Icons.person;
              break;
            case "Leisure":
              icon = Icons.movie;
              break;
            case "Medicin":
              icon = Icons.medical_information;
              break;
            case "Transport":
              icon = Icons.emoji_transportation;
              break;
            default:
              icon = Icons.help;
          }
          return Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: isSelected ? TColor.gray50 : Colors.transparent,
            ),
            child: ListTile(
              title: Text(
                item,
                style: TextStyle(color: TColor.white),
              ),
              leading: Icon(
                icon,
                color: TColor.white,
              ),
            ),
          );
        },
        menuProps: MenuProps(
          backgroundColor: TColor.gray50,
          borderRadius: BorderRadius.circular(25),
        ),
        showSelectedItems: true,
      ),
      items: items2,
      dropdownButtonProps: DropdownButtonProps(
        color: TColor.border,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: TextStyle(color: TColor.white),
        dropdownSearchDecoration: InputDecoration(
          label: Text(
            "Choose A Type",
            style: TextStyle(color: TColor.border),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
    );
  }
}
