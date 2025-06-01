import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/singleton/shared_pref.dart';
import '../../../core/utility/custom_appbar.dart';
import '../../core/provider/auth_provider.dart';
import '../../core/utility/colors.dart';
import '../../core/utility/customStrings.dart';
import '../../core/utility/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageScreenState createState() => LoginPageScreenState();
}

class LoginPageScreenState extends State<LoginPage> {
  String logged = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible = true;
  bool remember = true;

  @override
  void initState() {
    super.initState();
  }

  _loadHomeData({required bool isReload}) {
    logged = SharedPref.getString(CustomStrings().token);
    //context.read<CommonProvider>().categoryCall();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // Set
        child: CustomAppBar(
          title: CustomStrings().login,
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
                    spacing: 15,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Welcome Back",
                        style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: ProjectColors().primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Login to access your account",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ProjectColors().blue1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),

                      Form(
                        key: _formKey,
                        child: Column(
                          spacing: 10,
                          children: <Widget>[
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                "Email Address",
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
                              controller: usernameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return CustomStrings().required;
                                }
                                return null; // Valid input
                              },
                              keyboardType: TextInputType.emailAddress,
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
                                  borderSide: BorderSide(
                                    color: Colors.red.shade800,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22.0),
                                  borderSide: BorderSide(
                                    color: ProjectColors().primaryColor,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22.0),
                                  borderSide: BorderSide(
                                    color: Colors.red.shade800,
                                    width: 1,
                                  ),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(
                                  20.0,
                                  15.0,
                                  20.0,
                                  15.0,
                                ),
                                hintText: "Enter Email Address",
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
                                  borderSide: BorderSide(
                                    color: Colors.red.shade800,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22.0),
                                  borderSide: BorderSide(
                                    color: ProjectColors().primaryColor,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22.0),
                                  borderSide: BorderSide(
                                    color: Colors.red.shade800,
                                    width: 1,
                                  ),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(
                                  20.0,
                                  15.0,
                                  20.0,
                                  15.0,
                                ),
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListTile(
                              minLeadingWidth: 0,
                              contentPadding: EdgeInsets.all(0),
                              horizontalTitleGap: 0,
                              leading: Checkbox(
                                value: remember,
                                onChanged: (value) {
                                  setState(() {
                                    remember = !remember;
                                  });
                                },
                              ),
                              title: Text(
                                "Remember me",
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ProjectColors().blue3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forget Password?",
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: ProjectColors().blue1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 100),

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
                            if (_formKey.currentState!.validate()) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              context
                                  .read<AuthProvider>()
                                  .signInCall(
                                    password: passwordController.text,
                                    username: usernameController.text,
                                  )
                                  .then((value) {
                                    if (value == 200) {
                                      if (!context.mounted) return;
                                      SharedPref.setModel(
                                        CustomStrings().loginModel,
                                        context
                                            .read<AuthProvider>()
                                            .logInResponse
                                            .data,
                                      );
                                      SharedPref.setString(
                                        CustomStrings().token,
                                        "Bearer ${context.read<AuthProvider>().logInResponse.data!.token!}",
                                      );
                                      Navigator.pushReplacementNamed(
                                        context,
                                        mainPage,
                                      );
                                    }
                                  });
                            }
                          },
                          child: Text(
                            "Sign In",
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
}
