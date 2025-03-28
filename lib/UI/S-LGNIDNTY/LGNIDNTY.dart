// ignore_for_file: use_build_context_synchronously

import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parbank/UI/S-LGNPSWRD/LGNPSWRD.dart';
import 'package:parbank/UI/S-MRKTINFO/MRKTINFO.dart';
import 'package:parbank/UI/S-REGISTERF/REGISTERF.dart';
import 'package:parbank/api/ENV.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/api/URequestTypes.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/ULabel.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/components/UTextButton.dart';
import 'package:parbank/dto/DTOLogin.dart';
import 'package:parbank/dto/DTOParameter.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UAsset.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class LGNIDNTY extends StatefulWidget {
  const LGNIDNTY({super.key});

  @override
  State<LGNIDNTY> createState() => _LGNIDNTYState();
}

class _LGNIDNTYState extends State<LGNIDNTY> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UScaffold(
        isLogged: false,
        actions: [
          UTextButton(
            onPressed: () {
              setState(() {
                Localizer.index = Localizer.index == 0 ? 1 : 0;
              });
            },
            child: UText(
              Localizer.Get(Localizer.index_text),
              color: UColor.WhiteColor,
            ),
          )
        ],
        body: Center(
          child: Column(
            children: [
              Gap(USize.Height / 12),
              FutureBuilder(
                future: Future.wait([
                  HelperMethods.GetFullName(),
                  HelperMethods.GetIdentityNo()
                ]),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data![0]!.isNotEmpty) {
                    controller.text = snapshot.data![1]!;
                    return Column(
                      children: [
                        DashedCircle(
                          color: UColor.SecondColor,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: CircleAvatar(
                              radius: 70.0,
                              backgroundColor: UColor.SecondColor,
                              child: UText(
                                snapshot.data![0]!.characters.first
                                        .toUpperCase() +
                                    snapshot.data![0]!
                                        .split(' ')
                                        .last
                                        .characters
                                        .first
                                        .toUpperCase(),
                                fontSize: 51,
                                color: UColor.SecondHeavyColor,
                              ),
                            ),
                          ),
                        ),
                        Gap(USize.Height / 17),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            UText(
                              Localizer.Get(Localizer.welcome___with_comma),
                              fontSize: 17,
                            ),
                            UText(
                              snapshot.data![0]!,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            UTextButton(
                                onPressed: () {
                                  HelperMethods.SetBottomSheet(
                                      context,
                                      Localizer.Get(Localizer
                                          .customer_will_logged_out_to_change),
                                      UAsset.LOGOUT,
                                      Localizer.Get(Localizer.approve),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          UButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: UText(
                                                Localizer.Get(
                                                    Localizer.nevermind),
                                                color: UColor.WhiteColor,
                                              )),
                                          Gap(USize.Width / 33),
                                          UButton(
                                            onPressed: () async {
                                              await HelperMethods.DeleteData();
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                            redButton: true,
                                            child: UText(
                                              Localizer.Get(Localizer.log_out),
                                              color: UColor.WhiteColor,
                                            ),
                                          ),
                                        ],
                                      ));
                                },
                                child: UText(
                                  Localizer.Get(Localizer.change_customer),
                                  color: UColor.SecondHeavyColor,
                                )),
                            const Icon(
                              Icons.swap_horiz,
                              color: UColor.SecondHeavyColor,
                            )
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: USize.Height / 10, bottom: USize.Height / 10),
                      child: ULabel(
                        label: Localizer.Get(Localizer.identity_no),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Pinput(
                            length: 11,
                            controller: controller,
                            focusNode: focusNode,
                            separatorBuilder: (index) => Container(
                              height: USize.Width / 13,
                              width: 1,
                              color: Colors.white,
                            ),
                            defaultPinTheme: PinTheme(
                              width: USize.Width / 13,
                              height: USize.Width / 13,
                              textStyle: GoogleFonts.poppins(
                                  fontSize: 19, color: Colors.white),
                              decoration: const BoxDecoration(
                                  color: UColor.PrimaryLightColor),
                            ),
                            showCursor: true,
                            focusedPinTheme: PinTheme(
                              width: USize.Width / 13,
                              height: USize.Width / 13,
                              textStyle: GoogleFonts.poppins(
                                  fontSize: 19, color: Colors.white),
                              decoration: const BoxDecoration(
                                  color: UColor.PrimaryColor),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              Gap(USize.Height / 22),
              UButton(
                  onPressed: () async {
                    if (controller.text.length != 11) {
                      HelperMethods.SetBottomSheet(
                          context,
                          Localizer.Get(Localizer.incorrect_identity_no_entry) +
                              Localizer.Get(
                                  Localizer.identity_no_must_be_11_char_long),
                          UAsset.ERROR_GIF,
                          Localizer.Get(Localizer.error),
                          UButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: UText(
                                Localizer.Get(Localizer.ok),
                                color: UColor.WhiteColor,
                              )));
                    } else {
                      HelperMethods.SetLoadingScreen(context);
                      MessageContainer request = MessageContainer();
                      request.Add(
                          "DTOLogin", DTOLogin(IdentityNo: controller.text));
                      MessageContainer response;
                      try {
                        response = await UProxy.Request(
                          URequestTypes.GET,
                            IService.GET_LOGIN_CREDENTIALS, request);
                      } catch (e) {
                        HelperMethods.ApiException(context, e.toString());
                        return;
                      }
                      if (response.GetWithKey(
                              "BankingApp.Common.DataTransferObjects.DTOLogin") !=
                          null) {
                        DTOLogin dtoLogin = response.GetWithKey(
                            "BankingApp.Common.DataTransferObjects.DTOLogin");
                        ENV.Token = dtoLogin.Token;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LGNPSWRD(
                                      dtoLogin: dtoLogin,
                                    )));
                      } else {
                        controller.text = "";
                        HelperMethods.ApiException(context, Localizer.Get(Localizer
                                .no_customers_matching_entered_information));
                        
                      }
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UText(
                        Localizer.Get(Localizer.login),
                        color: UColor.WhiteColor,
                      ),
                      Gap(USize.Width / 100),
                      UIcon(
                        Icons.arrow_right,
                        color: UColor.WhiteColor,
                      )
                    ],
                  )),
              UTextButton(
                  onPressed: () async {
                    if (await HelperMethods.GetFullName() != "") {
                      HelperMethods.SetBottomSheet(
                          context,
                          Localizer.Get(
                              Localizer.customer_will_logged_out_to_create_new),
                          UAsset.LOGOUT,
                          Localizer.Get(Localizer.approve),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: UText(
                                    Localizer.Get(Localizer.nevermind),
                                    color: UColor.WhiteColor,
                                  )),
                              Gap(USize.Width / 33),
                              UButton(
                                onPressed: () async {
                                  HelperMethods.DeleteData();
                                  await setNewCustomerValues();
                                },
                                redButton: true,
                                child: UText(
                                  Localizer.Get(Localizer.log_out),
                                  color: UColor.WhiteColor,
                                ),
                              ),
                            ],
                          ));
                    } else {
                      await setNewCustomerValues();
                    }
                  },
                  child: UText(
                    Localizer.Get(Localizer.i_want_to_be_a_customer),
                    color: UColor.PrimaryColor,
                  )),
              Gap(USize.Height / 16),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      width: USize.Width / 3,
                      height: USize.Width / 4,
                      margin: EdgeInsets.only(
                          right: USize.Width / 3, bottom: USize.Width / 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UIconButton(
                            icon: UIcon(
                              Icons.qr_code_scanner,
                            ),
                            tooltip:
                                Localizer.Get(Localizer.qr_code_operations),
                          ),
                          UText(
                            Localizer.Get(Localizer.qr_code_operations),
                          )
                        ],
                      )),
                  Container(
                      width: USize.Width / 3,
                      height: USize.Width / 4,
                      margin: EdgeInsets.only(
                          left: USize.Width / 3, bottom: USize.Width / 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UIconButton(
                            icon: UIcon(
                              Icons.notifications_none_outlined,
                            ),
                            tooltip: Localizer.Get(Localizer.notifications),
                          ),
                          UText(
                            Localizer.Get(Localizer.notifications),
                          )
                        ],
                      )),
                  Container(
                      width: USize.Width / 3,
                      height: USize.Width / 4,
                      margin: EdgeInsets.only(
                          left: USize.Width / 3, top: USize.Width / 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UIconButton(
                            icon: UIcon(
                              Icons.calculate_outlined,
                            ),
                            tooltip:
                                Localizer.Get(Localizer.credit_calculation),
                          ),
                          UText(
                            Localizer.Get(Localizer.credit_calculation),
                          )
                        ],
                      )),
                  GestureDetector(
                    onTap: () async {
                      HelperMethods.SetLoadingScreen(context);
                      List currencyList;

                      try {
                        currencyList = await UProxy.Request(
                      URequestTypes.GET,
                            IService.GET_PARAMETERS_BY_GROUP_CODE,
                            MessageContainer.builder({
                              "DTOParameter": DTOParameter(GroupCode: "Currency")
                            })).then((value) {
                          return value.GetWithKey("ParameterList");
                        });
                      } catch (e) {
                        HelperMethods.ApiException(context, e.toString());
                        return;
                      }
                      for (var i = 0; i < currencyList.length; i++) {
                        currencyList[i] =
                            DTOParameter.fromJson(currencyList[i]);
                      }

                      currencyList.removeWhere((x) => x.Description == "TL");

                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MRKTINFO(
                              Currencies: currencyList,
                            ),
                          ));
                    },
                    child: Container(
                        width: USize.Width / 3,
                        height: USize.Width / 4,
                        margin: EdgeInsets.only(
                            right: USize.Width / 3, top: USize.Width / 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UIconButton(
                              icon: UIcon(Icons.currency_exchange),
                              tooltip:
                                  Localizer.Get(Localizer.market_information),
                            ),
                            UText(
                              Localizer.Get(Localizer.market_information),
                            )
                          ],
                        )),
                  ),
                  Container(
                    height: 1,
                    width: USize.Width / 1.5,
                    color: Colors.black,
                  ),
                  Container(
                    height: USize.Width / 2,
                    width: 1,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  setNewCustomerValues() async {
    HelperMethods.SetLoadingScreen(context);

    List parList = [
      DTOParameter(GroupCode: "City"),
      DTOParameter(GroupCode: "District"),
      DTOParameter(GroupCode: "Gender"),
      DTOParameter(GroupCode: "Profession")
    ];
    List cityList;
    List districtList;
    List professionList;
    List genderList;

    try {
      parList = await UProxy.Request(
                      URequestTypes.GET,IService.GET_MULTIPLE_GROUP_CODE,
          MessageContainer.builder({"List<DTOParameter>": parList})).then((value) {
        return value.GetWithKey("ParameterList");
      });
    } catch (e) {
      HelperMethods.ApiException(context, e.toString());
      return;
    }

    for (var i = 0; i < parList.length; i++) {
      parList[i] = DTOParameter.fromJson(parList[i]);
    }

    cityList = parList.where((x) => x.GroupCode == "City").toList();
    districtList = parList.where((x) => x.GroupCode == "District").toList();
    professionList = parList.where((x) => x.GroupCode == "Profession").toList();
    genderList = parList.where((x) => x.GroupCode == "Gender").toList();

    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => REGISTERF(
                cityList: cityList,
                districtList: districtList,
                professionList: professionList,
                genderList: genderList)));
  }
}
