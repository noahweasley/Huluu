import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class CenterAreaSubmitRedeemScreen extends StatelessWidget {
  final String wallet;
  final VoidCallback onSubmitBtnTap;
  final TextEditingController accountDetailController;
  final String? payment;
  final Function(String? value) onPaymentChange;
  final List<String> paymentList;
  final String accountError;
  final bool isEmpty;

  const CenterAreaSubmitRedeemScreen(
      {Key? key,
      required this.wallet,
      required this.onSubmitBtnTap,
      required this.accountDetailController,
      required this.payment,
      required this.onPaymentChange,
      required this.paymentList,
      required this.accountError,
      required this.isEmpty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: 156,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorRes.lightGrey2,
                    image: const DecorationImage(
                        image: AssetImage(AssetRes.map3))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 19, left: 18, right: 17, bottom: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                S.current.wallet,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: ColorRes.lightGrey5,
                                  letterSpacing: 2,
                                  fontFamily: FontRes.semiBold,
                                ),
                              ),
                              const Spacer(),
                              Image.asset(
                                AssetRes.themeLabel,
                                height: 23,
                                width: 76,
                              ),
                              Text(
                                S.current.liveCAp,
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                NumberFormat.compactCurrency(
                                        decimalDigits: 0,
                                        locale: 'en_US',
                                        name: '')
                                    .format(int.parse(wallet)),
                                style: const TextStyle(
                                    color: ColorRes.lightGrey4,
                                    letterSpacing: 2,
                                    fontSize: 22,
                                    fontFamily: FontRes.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '(${NumberFormat.compactCurrency(decimalDigits: 0, locale: 'en_US', symbol: '\$').format(
                                  int.parse(wallet) *
                                      double.parse(PrefService.coinRate),
                                )})',
                                style: const TextStyle(
                                    color: ColorRes.lightGrey5,
                                    letterSpacing: 2,
                                    fontSize: 15,
                                    fontFamily: FontRes.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 17),
                          Container(
                            height: 7,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorRes.lightOrange1,
                                  ColorRes.darkOrange,
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${S.current.threshold} ${PrefService.minThreshold}',
                                style: const TextStyle(
                                  color: ColorRes.lightGrey4,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '1 Diamond = ${PrefService.currency} ${PrefService.coinRate}',
                                style: const TextStyle(
                                  color: ColorRes.lightGrey4,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 21),
              Text(
                S.of(context).paymentGateway,
                style: const TextStyle(
                  color: ColorRes.darkGrey3,
                  fontSize: 15,
                  fontFamily: FontRes.extraBold,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: Get.width,
                height: 48,
                padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorRes.lightGrey2,
                ),
                child: DropdownButton(
                    // Initial Value
                    style: const TextStyle(
                      color: ColorRes.dimGrey3,
                      fontSize: 14,
                    ),
                    underline: const SizedBox(),
                    value: payment,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(15),
                    // Down Arrow Icon
                    icon: Container(
                      height: 37,
                      width: 37,
                      padding: const EdgeInsets.only(right: 3),
                      child: Center(
                        child: Image.asset(
                          AssetRes.downArrow,
                        ),
                      ),
                    ),
                    // Array list of items
                    items: paymentList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: const TextStyle(fontFamily: FontRes.regular),
                        ),
                      );
                    }).toList(),
                    onChanged: onPaymentChange),
              ),
              const SizedBox(height: 18),
              Text(
                S.of(context).accountDetails,
                style: const TextStyle(
                  color: ColorRes.darkGrey3,
                  fontSize: 15,
                  fontFamily: FontRes.extraBold,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 67,
                width: Get.width,
                padding: const EdgeInsets.only(left: 12, top: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorRes.lightGrey2,
                    border: Border.all(
                        color: isEmpty
                            ? ColorRes.darkOrange
                            : ColorRes.transparent)),
                child: TextField(
                  controller: accountDetailController,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  decoration: InputDecoration(
                    hintText: accountError == ''
                        ? S.of(context).enterAccountDetails
                        : accountError,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintStyle: TextStyle(
                        color: accountError == ''
                            ? ColorRes.dimGrey3
                            : ColorRes.darkOrange,
                        fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 39),
              InkWell(
                onTap: onSubmitBtnTap,
                child: Container(
                  height: 41,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ColorRes.lightOrange1,
                        ColorRes.darkOrange,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      S.current.submit,
                      style: const TextStyle(
                        color: ColorRes.white,
                        fontSize: 12,
                        fontFamily: FontRes.semiBold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
