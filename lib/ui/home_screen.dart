import 'package:algo_x/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:algo_x/bloc/home_screen_bloc/home_screen_event.dart';
import 'package:algo_x/bloc/home_screen_bloc/home_screen_state.dart';
import 'package:algo_x/locators/app_colors.dart';
import 'package:algo_x/models/transaction_explorer.dart';
import 'package:algo_x/utils/extends/string_extension.dart';
import 'package:algo_x/utils/navigator_service.dart';
import 'package:algo_x/utils/routes.dart';
import 'package:algo_x/widgets/app_device_builder.dart';
import 'package:algo_x/widgets/app_text.dart';
import 'package:algo_x/widgets/app_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'dart:math' as math;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeScreenBloc>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is HomeAccountInformationLoadedState) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: <Widget>[
                        AppTopBar(
                          title: 'Home',
                          hasBackButton: false,
                          leftIcon: IconButton(
                            onPressed: () => bloc.add(HomeOnExistPressed()),
                            icon: Transform(
                              transform: Matrix4.rotationY(math.pi),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.exit_to_app,
                                size: 30,
                                color: Colors.red.shade400,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: state.account.publicAddress,
                                ),
                              );
                              const snackBar = SnackBar(
                                content: Text('Copiado en el portapapeles'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IgnorePointer(
                              child: card(
                                color: AppColors.background2,
                                child: Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.copy,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        AppText(text: 'Direccion'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: AppText(
                                            text:
                                                '${state.accountInformation.address} ',
                                            textAlign: TextAlign.center,
                                            size: 14,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText(
                                text:
                                    '${state.accountInformation.amount.toAlgorandString()} ',
                                textAlign: TextAlign.center,
                                size: 40,
                              ),
                              Image.asset(
                                'assets/images/algorand_logo.png',
                                height: 80,
                                width: 80,
                              ),
                            ],
                          ),
                          color: AppColors.background2,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 120,
                          child: Row(
                            children: [
                              Expanded(
                                child: card(
                                  onTap: () {
                                    NavigationService.instance.navigateTo(
                                        Routes.qrScreen,
                                        args: state.account.publicAddress);
                                  },
                                  child: Column(
                                    children: const [
                                      AppText(
                                        text: 'Mi QR',
                                        size: 22,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.text,
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.qr_code,
                                        color: AppColors.text3,
                                        size: 60,
                                      )
                                    ],
                                  ),
                                  color: Colors.green.shade400,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: card(
                                    onTap: () => bloc.add(HomeAddMoneyEvent()),
                                    child: Column(
                                      children: [
                                        AppDeviceBuilder(
                                            builder: (context, device, size) {
                                          print(device.toString());
                                          print(size.width.toString());
                                          return AppText(
                                            text: 'Enviar Dinero',
                                            size: device == Devices.mobile
                                                ? 18
                                                : 22,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.text,
                                          );
                                        }),
                                        const Spacer(),
                                        const Icon(
                                          Icons.send,
                                          color: AppColors.text,
                                          size: 60,
                                        )
                                      ],
                                    ),
                                    color: Colors.blue.shade400),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        transactions(state, size),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: LoadingAnimationWidget.halfTriangleDot(
                    color: Colors.orange, size: 50),
              );
            }
          },
        ),
      ),
    );
  }

  Widget card({required Widget child, Color? color, void Function()? onTap}) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap() : null,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 16, right: 10, left: 10),
          child: child,
        ),
      ),
    );
  }

  Widget transactions(HomeAccountInformationLoadedState state, Size size) {
    List<TransactionExplorer> transactions = state.transactions;
    if (transactions.isEmpty) {
      return Container(
        height: 160,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: AppColors.background2,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              AppText(
                text: 'Transacciones',
                textAlign: TextAlign.left,
                size: 22,
                fontWeight: FontWeight.w400,
              ),
              Expanded(
                child: Center(
                  child: AppText(
                    text: 'No tienes transacciones aún',
                    color: AppColors.text2,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      double rowSize = size.width * 0.8 > 500 ? 400 : size.width * 0.8;
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: AppColors.background2,
        ),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                text: 'Transacciones',
                textAlign: TextAlign.left,
                size: 22,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: transactions.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: ((context, index) {
                  var transaction = transactions[index];
                  return Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.background3,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16, left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          AppText(
                            text: transaction.transactionSendToString(
                              state.account.publicAddress,
                            ),
                            softWrap: false,
                            textOverflow: TextOverflow.fade,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppText(
                            text: transaction.amount.toAlgorandString(),
                            color: transaction
                                .imSender(state.account.publicAddress) ? Colors.red.shade400 : Colors.green.shade400,
                            softWrap: false,
                            maxLines: 1,
                            textOverflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      );
    }
  }
}
