import 'package:algo_x/bloc/add_money_screen_bloc/send_money_event.dart';
import 'package:algo_x/bloc/add_money_screen_bloc/send_money_screen_bloc.dart';
import 'package:algo_x/bloc/add_money_screen_bloc/send_money_state.dart';
import 'package:algo_x/locators/app_colors.dart';
import 'package:algo_x/widgets/app_button.dart';
import 'package:algo_x/widgets/app_circle_button.dart';
import 'package:algo_x/widgets/app_text.dart';
import 'package:algo_x/widgets/app_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMoneyScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final TextEditingController _addresController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  SendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SendMoneyScreenBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state is SendMoneyAddresPagePassedState) {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuart);
          } else if (state is SendMoneyGoBackState) {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuart);
          }
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AppTopBar(
                      title: 'Enviar Dinero',
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          addressPage(context),
                          amountPage(context),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget amountPage(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300),
                child: amountTextField(),
              ),
            ),
          ],
        ),
        BlocBuilder(
          bloc: BlocProvider.of<SendMoneyScreenBloc>(context),
          builder: (context, state) {
            if (state is SendMoneyInsuficientAmountState) {
              return const AppText(text: 'No tienes suficientes fondos');
            }

            return Container();
          },
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppCircleButton(
              icon: Icons.chevron_left_outlined,
              size: 30,
              onPressed: () =>
                  BlocProvider.of<SendMoneyScreenBloc>(context).add(
                SendMoneyBackPageEvent(),
              ),
            ),
            AppButton(
              text: 'Siguiente',
              textSize: 15,
              onPressed: () =>
                  BlocProvider.of<SendMoneyScreenBloc>(context).add(
                SendMoneyFinalStepPressedEvent(
                  currentPage: _pageController.page!.floor(),
                  address: _addresController.text,
                  amount: _amountController.text,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget addressPage(BuildContext context) {
    final bloc = BlocProvider.of<SendMoneyScreenBloc>(context);
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300),
                child: addressTextField(),
              ),
            ),
          ],
        ),
        BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is SendMoneyAddressEmtpyErrorState) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: AppText(
                    text: 'Debe rellenar el campo dirección',
                    color: Colors.red.shade400,
                  ),
                );
              }

              return Container();
            }),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            AppButton(
              text: 'Siguiente',
              textSize: 15,
              onPressed: () =>
                  BlocProvider.of<SendMoneyScreenBloc>(context).add(
                SendMoneyToAmountPagePressedEvent(
                  currentPage: _pageController.page!.floor(),
                  address: _addresController.text,
                  amount: _amountController.text,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget addressTextField() {
    return TextField(
      controller: _addresController,
      cursorColor: AppColors.primary,
      style: const TextStyle(color: AppColors.text),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        filled: true,
        fillColor: AppColors.background2,
        labelStyle: const TextStyle(color: AppColors.secondary),
        hintStyle: const TextStyle(color: Colors.green),
        focusColor: Colors.red,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(25.0),
        ),
        labelText: 'Dirección',
        floatingLabelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.secondary,
        ),
      ),
    );
  }

  Widget amountTextField() {
    return TextField(
      controller: _amountController,
      cursorColor: AppColors.primary,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      style: const TextStyle(color: AppColors.text),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        filled: true,
        fillColor: AppColors.background2,
        labelStyle: const TextStyle(color: AppColors.secondary),
        hintStyle: const TextStyle(color: Colors.green),
        focusColor: Colors.red,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(25.0),
        ),
        labelText: 'Cantidad',
        floatingLabelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
