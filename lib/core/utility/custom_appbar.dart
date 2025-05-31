import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final Function() onTap;

  const CustomAppBar({super.key, required this.title, required this.onTap});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String logged = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(
        kToolbarHeight,
      ), // Set the preferred height
      child: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ProjectColors().white2,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
        centerTitle: true,
        backgroundColor: ProjectColors().primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ProjectColors().white,
            size: 28,
          ),
          iconSize: 40,
          onPressed: widget.onTap,
        ),
      ),
    );
  }
}
