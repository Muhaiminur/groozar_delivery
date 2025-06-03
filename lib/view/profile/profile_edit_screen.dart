import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/singleton/shared_pref.dart';
import '../../../core/utility/custom_appbar.dart';
import '../../core/provider/auth_provider.dart';
import '../../core/utility/colors.dart';
import '../../core/utility/customStrings.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ProfileEditPageScreenState createState() => ProfileEditPageScreenState();
}

class ProfileEditPageScreenState extends State<ProfileEditPage> {
  String logged = "";
  final GlobalKey<FormState> _userFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _loadHomeData(isReload: false);
  }

  _loadHomeData({required bool isReload}) {
    logged = SharedPref.getString(CustomStrings().token);
    context.read<AuthProvider>().userDetailsCall().then((value) {
      nameController.text = value.data?.fullName ?? "";
      numberController.text = value.data?.phone ?? "";
      emailController.text = value.data?.email ?? "";
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors().white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // Set
        child: CustomAppBar(
          title: "Update Profile",
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          color: ProjectColors().primaryColor,
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ProjectColors().white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue.shade200,
                              radius: 50,
                              child:
                                  context
                                              .watch<AuthProvider>()
                                              .userDetailsResponse
                                              .data
                                              ?.fullName !=
                                          null
                                      ? CachedNetworkImage(
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            context
                                                .watch<AuthProvider>()
                                                .userDetailsResponse
                                                .data
                                                ?.fullName ??
                                            "",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                                  height: 90,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                        placeholder:
                                            (context, url) =>
                                                CircularProgressIndicator(),
                                        errorWidget:
                                            (context, url, error) =>
                                                SvgPicture.asset(
                                                  height: 90,
                                                  width: 90,
                                                  "assets/images/ic_user.svg",
                                                  fit: BoxFit.cover,
                                                ),
                                      )
                                      : SvgPicture.asset(
                                        height: 90,
                                        width: 90,
                                        "assets/images/ic_user.svg",
                                        fit: BoxFit.cover,
                                      ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: ProjectColors().white,
                                radius: 20,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ProfileEditPage(),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 18,
                                    color: Color(0xFF30DBF2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      userView(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: WidgetStateProperty.all(Size.zero),
                            // Set
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                              ProjectColors().primaryColor,
                            ),
                            padding: WidgetStateProperty.all(
                              EdgeInsets.fromLTRB(45, 10, 45, 10),
                            ),
                            textStyle: WidgetStateProperty.all(
                              TextStyle(
                                fontSize: 16,
                                color: ProjectColors().white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_userFormKey.currentState!.validate()) {
                              context
                                  .read<AuthProvider>()
                                  .userUpdateCall(
                                    username: nameController.text,
                                    password: passwordController.text,
                                    phone: numberController.text,
                                  )
                                  .then((value) {
                                    if (value == 200) {
                                      Navigator.pop(context);
                                    }
                                  });
                            }
                          },
                          child: Text(
                            "Save Changes",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ProjectColors().white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userView() {
    return Form(
      key: _userFormKey,
      child: Column(
        spacing: 10,
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Full Name",
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ProjectColors().blue1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.start,
            ),
          ),
          TextFormField(
            style: GoogleFonts.roboto(
              color: ProjectColors().blue1,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return CustomStrings().required;
              }
              return null; // Valid input
            },
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              fillColor: ProjectColors().white,
              filled: true,
              hintStyle: GoogleFonts.roboto(
                color: ProjectColors().blue1,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.red.shade800, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0),
                borderSide: BorderSide(color: ProjectColors().primaryColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0),
                borderSide: BorderSide(color: Colors.red.shade800, width: 1),
              ),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Enter Full Name",
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: ProjectColors().white4),
                borderRadius: BorderRadius.circular(22.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: ProjectColors().white4),
                borderRadius: BorderRadius.circular(22.0),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Email",
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ProjectColors().blue1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.start,
            ),
          ),
          TextFormField(
            enabled: false,
            style: GoogleFonts.roboto(
              color: ProjectColors().blue1,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return CustomStrings().required;
              }
              return null; // Valid input
            },
            keyboardType: TextInputType.numberWithOptions(
              decimal: false,
              signed: false,
            ),
            decoration: InputDecoration(
              fillColor: ProjectColors().white,
              filled: true,
              hintStyle: GoogleFonts.roboto(
                color: ProjectColors().blue1,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.red.shade800, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0),
                borderSide: BorderSide(color: ProjectColors().primaryColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0),
                borderSide: BorderSide(color: Colors.red.shade800, width: 1),
              ),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Enter Phone Number",
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: ProjectColors().white4),
                borderRadius: BorderRadius.circular(22.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: ProjectColors().white4),
                borderRadius: BorderRadius.circular(22.0),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Phone number",
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ProjectColors().blue1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.start,
            ),
          ),
          TextFormField(
            style: GoogleFonts.roboto(
              color: ProjectColors().blue1,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            controller: numberController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return CustomStrings().required;
              }
              return null; // Valid input
            },
            keyboardType: TextInputType.numberWithOptions(
              decimal: false,
              signed: false,
            ),
            decoration: InputDecoration(
              fillColor: ProjectColors().white,
              filled: true,
              hintStyle: GoogleFonts.roboto(
                color: ProjectColors().blue1,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.red.shade800, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0),
                borderSide: BorderSide(color: ProjectColors().primaryColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0),
                borderSide: BorderSide(color: Colors.red.shade800, width: 1),
              ),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Enter Phone Number",
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: ProjectColors().white4),
                borderRadius: BorderRadius.circular(22.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: ProjectColors().white4),
                borderRadius: BorderRadius.circular(22.0),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Password",
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ProjectColors().blue1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.start,
            ),
          ),
          TextFormField(
            style: GoogleFonts.roboto(
              color: ProjectColors().blue1,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return CustomStrings().required;
              }
              return null; // Valid input
            },
            obscureText: passwordVisible,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              fillColor: ProjectColors().white,
              filled: true,
              hintStyle: GoogleFonts.roboto(
                color: ProjectColors().blue1,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.red.shade800, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0),
                borderSide: BorderSide(color: ProjectColors().primaryColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0),
                borderSide: BorderSide(color: Colors.red.shade800, width: 1),
              ),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "*********",
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: ProjectColors().white4),
                borderRadius: BorderRadius.circular(22.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: ProjectColors().white4),
                borderRadius: BorderRadius.circular(22.0),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: ProjectColors().blue1,
                ),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
