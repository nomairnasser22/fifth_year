import 'package:flutter/material.dart';
import '../theme.dart';

class MyListTile extends StatelessWidget {
  final String type;
  final String title;
  final String price;
  final String date;

  const MyListTile({
    super.key,
    required this.type,
    required this.title,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    switch (type) {
      case "Food": 
        iconData = Icons.fastfood;
        break;
      case "Leisure":
        iconData = Icons.movie;
        break;
      case "Medicin":
        iconData = Icons.medical_information;
        break;
      case "Cloths":
        iconData = Icons.person;
        break;
      case "Transport":
        iconData = Icons.emoji_transportation;
        break;
      default:
        iconData = Icons.help_outline;
        break;
    }
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1.5,
              color: TColor.border.withOpacity(0.3),
            ),
          ),
          child: ListTile(
            leading: Icon(
              iconData,
              color: TColor.white.withOpacity(0.6),
            ),
            title: Text(title),
            subtitle: Text(date),
            trailing: Column(
              children: [
                const SizedBox(height: 10),
                Text(type,
                    style: TextStyle(color: TColor.white.withOpacity(0.6))),
                Text('\$$price',
                    style: TextStyle(color: TColor.white.withOpacity(0.6))),
              ],
            ),
            textColor: TColor.white,
          ),
        ),
      ),
    );
  }
}
