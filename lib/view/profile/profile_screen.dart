import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grozaar_delivery/view/profile/profile_edit_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/singleton/shared_pref.dart';
import '../../../core/utility/custom_appbar.dart';
import '../../core/provider/auth_provider.dart';
import '../../core/utility/colors.dart';
import '../../core/utility/customStrings.dart';
import '../../core/utility/routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageScreenState createState() => ProfilePageScreenState();
}

class ProfilePageScreenState extends State<ProfilePage> {
  String logged = "";

  @override
  void initState() {
    super.initState();
    _loadHomeData(isReload: false);
  }

  _loadHomeData({required bool isReload}) {
    logged = SharedPref.getString(CustomStrings().token);
    context.read<AuthProvider>().userDetailsCall();
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
          title: "My Profile",
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
                      Card(
                        color: ProjectColors().ash1,
                        margin: EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue.shade200,
                                radius: 20,
                                child:
                                    context
                                                .watch<AuthProvider>()
                                                .userDetailsResponse
                                                .data
                                                ?.fullName !=
                                            null
                                        ? CachedNetworkImage(
                                          height: 50,
                                          width: 50,
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
                                                    "assets/images/ic_user.svg",
                                                    fit: BoxFit.cover,
                                                  ),
                                        )
                                        : SvgPicture.asset(
                                          "assets/images/ic_user.svg",
                                          fit: BoxFit.cover,
                                        ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SizedBox(
                                        width: 210,
                                        child: Text(
                                          context
                                                  .watch<AuthProvider>()
                                                  .userDetailsResponse
                                                  .data
                                                  ?.fullName ??
                                              "",
                                          style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: ProjectColors().primaryColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          ProfileEditPage(),
                                                ),
                                              )
                                              .then((_) {
                                                setState(() {});
                                                _loadHomeData(isReload: false);
                                              });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          size: 18,
                                          color: Color(0xFF30DBF2),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    context
                                            .watch<AuthProvider>()
                                            .userDetailsResponse
                                            .data
                                            ?.email ??
                                        "",
                                    style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: ProjectColors().blue1,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    context
                                            .watch<AuthProvider>()
                                            .userDetailsResponse
                                            .data
                                            ?.phone ??
                                        "",
                                    style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: ProjectColors().blue1,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "Others Info",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ProjectColors().blue3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.start,
                      ),
                      Card(
                        color: ProjectColors().white,
                        margin: EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ListTile(
                                shape: RoundedRectangleBorder(),
                                minLeadingWidth: 0,
                                leading: SvgPicture.asset(
                                  "assets/images/ic_order_history.svg",
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text(
                                  "Order History",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: ProjectColors().blue1,
                                  ),
                                ),
                                onTap: () {
                                  //Navigator.pushNamed(context, orderListPage);
                                  /*Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const OrderListPage(),
                                    ),
                                  );*/
                                },
                                trailing: Icon(
                                  Icons.arrow_circle_right_sharp,
                                  size: 24,
                                  color: ProjectColors().primaryColor.withAlpha(
                                    90,
                                  ),
                                ),
                              ),
                              Divider(height: 1, color: ProjectColors().white3),
                              ListTile(
                                shape: RoundedRectangleBorder(),
                                minLeadingWidth: 0,
                                leading: SvgPicture.asset(
                                  "assets/images/ic_notification.svg",
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text(
                                  "Notifications",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: ProjectColors().blue1,
                                  ),
                                ),
                                onTap: () {
                                  /*Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PromotionPage(),
                                    ),
                                  );*/
                                },
                                trailing: Icon(
                                  Icons.arrow_circle_right_sharp,
                                  size: 24,
                                  color: ProjectColors().primaryColor.withAlpha(
                                    90,
                                  ),
                                ),
                              ),
                              Divider(height: 1, color: ProjectColors().white3),
                              ListTile(
                                shape: RoundedRectangleBorder(),
                                minLeadingWidth: 0,
                                leading: SvgPicture.asset(
                                  "assets/images/ic_logout.svg",
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text(
                                  "Log Out",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: ProjectColors().red1,
                                  ),
                                ),
                                onTap: () async {
                                  await SharedPref.remove(
                                    CustomStrings().token,
                                  );
                                  await SharedPref.clear();
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    loginPage,
                                    (route) => false,
                                  );
                                },
                              ),
                            ],
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
