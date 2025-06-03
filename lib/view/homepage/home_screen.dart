import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/singleton/shared_pref.dart';
import '../../core/provider/order_provider.dart';
import '../../core/utility/colors.dart';
import '../../core/utility/customColorLoader.dart';
import '../../core/utility/customStrings.dart';
import '../order/order_details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageScreenState createState() => HomePageScreenState();
}

class HomePageScreenState extends State<HomePage> {
  String logged = "";

  @override
  void initState() {
    super.initState();
    _loadHomeData(isReload: false);
  }

  _loadHomeData({required bool isReload}) {
    logged = SharedPref.getString(CustomStrings().token);
    context.read<OrderProvider>().currentOrderCall();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors().white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        backgroundColor: ProjectColors().primaryColor,
        elevation: 0.0,
      ),
      body: RefreshIndicator(
        color: ProjectColors().white,
        backgroundColor: ProjectColors().primaryColor,
        strokeWidth: 1.0,
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: ProjectColors().primaryColor,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Request",
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: ProjectColors().white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      Text(
                        "Showing all your order request",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: ProjectColors().white2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
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
                  child: Column(children: [onGoingView()]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    _loadHomeData(isReload: true);
  }

  Widget onGoingView() {
    return context.watch<OrderProvider>().currentOrderResponse.data?.data !=
                null &&
            context
                .watch<OrderProvider>()
                .currentOrderResponse
                .data!
                .data!
                .isNotEmpty
        ? ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemCount:
              context
                  .watch<OrderProvider>()
                  .currentOrderResponse
                  .data
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
                  spacing: 5,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context
                                    .watch<OrderProvider>()
                                    .currentOrderResponse
                                    .data
                                    ?.data
                                    ?.elementAt(index)
                                    ?.invoiceNo ??
                                "",
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ProjectColors().blue3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Text(
                          context
                                  .watch<OrderProvider>()
                                  .currentOrderResponse
                                  .data
                                  ?.data
                                  ?.elementAt(index)
                                  ?.time ??
                              "",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: ProjectColors().blue1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        context
                                .watch<OrderProvider>()
                                .currentOrderResponse
                                .data
                                ?.data
                                ?.elementAt(index)
                                ?.customer
                                ?.totalDueAmount ??
                            "",
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ProjectColors().blue1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                ProjectColors().primaryColor,
                              ),
                              padding: WidgetStateProperty.all(
                                EdgeInsets.only(left: 25, right: 25),
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(23),
                                ),
                              ),
                            ),
                            onPressed: () {
                              context
                                  .read<OrderProvider>()
                                  .orderUpdateCall(
                                context
                                    .read<OrderProvider>()
                                    .currentOrderResponse
                                    .data
                                    ?.data
                                    ?.elementAt(index)
                                    ?.id ??
                                    "",
                                "accepted",
                              )
                                  .then((value) {
                                context
                                    .read<OrderProvider>()
                                    .currentOrderCall();
                              });
                              if (context
                                      .read<OrderProvider>()
                                      .currentOrderResponse
                                      .data
                                      ?.data
                                      ?.elementAt(index)
                                      ?.status ==
                                  "Packaged") {

                              } else {}
                            },
                            child: Text(
                              "Accept",
                              /*context
                                      .watch<OrderProvider>()
                                      .currentOrderResponse
                                      .data
                                      ?.data
                                      ?.elementAt(index)
                                      ?.status ??
                                  ""*/
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: ProjectColors().white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                ProjectColors().white,
                              ),
                              padding: WidgetStateProperty.all(
                                EdgeInsets.only(left: 25, right: 25),
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(23),
                                  side: BorderSide(
                                    width: 1,
                                    color: Color(0xFFC3C8D0),
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => OrderDetailsPage(
                                        args: {
                                          "id":
                                              context
                                                  .read<OrderProvider>()
                                                  .currentOrderResponse
                                                  .data
                                                  ?.data
                                                  ?.elementAt(index)
                                                  ?.id ??
                                              "0",
                                        },
                                      ),
                                ),
                              );
                              /*Navigator.pushNamed(
                                context,
                                orderDetailsPage,
                                arguments: {
                                  "id":
                                      context
                                          .read<OrderProvider>()
                                          .orderHistoryResponse
                                          ?.data
                                          ?.data
                                          ?.elementAt(index)
                                          ?.id ??
                                      "0",
                                },
                              );*/
                            },
                            child: Text(
                              "View Details",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: ProjectColors().blue3,
                              ),
                            ),
                          ),
                        ),
                      ],
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
