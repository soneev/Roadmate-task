import 'package:flutter/material.dart';
import 'package:partnerapp/widgets/custom_text.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  List<Widget>? actions;

  CustomAppBar({super.key, required this.title, this.leading, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: CustomText(
        title,
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),

      backgroundColor:
          Colors.grey.withOpacity(0.1), // Set your custom background color

      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
