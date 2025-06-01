import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/singleton/shared_pref.dart';
import '../../../core/utility/customColorLoader.dart';
import '../../../core/utility/custom_appbar.dart';
import '../../core/provider/common_provider.dart';
import '../../core/utility/colors.dart';
import '../../core/utility/customStrings.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  PromotionPageScreenState createState() => PromotionPageScreenState();
}

class PromotionPageScreenState extends State<PromotionPage> {
  String logged = "";

  @override
  void initState() {
    super.initState();
    _loadHomeData(isReload: false);
  }

  _loadHomeData({required bool isReload}) {
    logged = SharedPref.getString(CustomStrings().token);
    //context.read<CommonProvider>().promotionCall();
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
          title: "Promotional offers",
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: RefreshIndicator(
        color: ProjectColors().white,
        backgroundColor: ProjectColors().primaryColor,
        strokeWidth: 1.0,
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          child: Container(
            color: ProjectColors().primaryColor,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ProjectColors().white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Column(children: [promoList()]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    _loadHomeData(isReload: true);
  }

  Widget promoList() {
    return context.watch<CommonProvider>().promotionResponse != null &&
            context.watch<CommonProvider>().promotionResponse?.data?.data !=
                null &&
            context
                .watch<CommonProvider>()
                .promotionResponse!
                .data!
                .data!
                .isNotEmpty
        ? ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount:
              context
                  .watch<CommonProvider>()
                  .promotionResponse
                  ?.data
                  ?.data
                  ?.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: ProjectColors().white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0x0a0f291a), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(
                      context
                              .watch<CommonProvider>()
                              .promotionResponse
                              ?.data
                              ?.data
                              ?.elementAt(index)
                              ?.title ??
                          "",
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
                    Text(
                      context
                              .watch<CommonProvider>()
                              .promotionResponse
                              ?.data
                              ?.data
                              ?.elementAt(index)
                              ?.description ??
                          "",
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: ProjectColors().blue3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      context
                              .watch<CommonProvider>()
                              .promotionResponse
                              ?.data
                              ?.data
                              ?.elementAt(index)
                              ?.endDate ??
                          "",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
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
              ),
            );
          },
        )
        : ColorLoader();
  }
}
