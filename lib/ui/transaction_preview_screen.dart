import 'package:algo_x/bloc/transaction_preview_bloc/transaction_preview_event.dart';
import 'package:algo_x/bloc/transaction_preview_bloc/transaction_preview_screen_bloc.dart';
import 'package:algo_x/bloc/transaction_preview_bloc/transaction_preview_state.dart';
import 'package:algo_x/locators/app_colors.dart';
import 'package:algo_x/widgets/app_button.dart';
import 'package:algo_x/widgets/app_device_builder.dart';
import 'package:algo_x/widgets/app_text.dart';
import 'package:algo_x/widgets/app_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TransactionPreviewScreen extends StatelessWidget {
  const TransactionPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TransactionPreviewScreenBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) {},
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Visibility(
                      visible: state is! TransactionPreviewAcceptedPaymentState,
                      child: const AppTopBar(
                        title: 'Detalles',
                      ),
                    ),
                    BlocBuilder(
                      bloc: bloc,
                      builder: (context, state) {
                        if (state is TransactionPreviewInitState) {
                          return detailView(bloc);
                        } else if (state is TransactionPreviewLoadingState) {
                          return Center(
                            child: LoadingAnimationWidget.halfTriangleDot(
                                color: Colors.orange, size: 50),
                          );
                        } else if (state
                            is TransactionPreviewAcceptedPaymentState) {
                          return Center(
                            child: AppText(
                              text: 'Tus Algos se han enviado correctamente',
                              color: Colors.green.shade400,
                            ),
                          );
                        } else {
                          return Expanded(
                            child: Center(
                              child: AppText(
                                text: 'Se ha producido un error',
                                color: Colors.red.shade400,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget detailView(TransactionPreviewScreenBloc bloc) {
    return AppDeviceBuilder(builder: (context, device, size) {
      if (device == Devices.mobile) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                text: 'Dirección de envio',
                textAlign: TextAlign.left,
                size: 22,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background2,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppText(text: bloc.address),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const AppText(
                text: 'Cantidad',
                textAlign: TextAlign.left,
                size: 22,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background2,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppText(text: '${bloc.amount} ALGO'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 50,
                        child: AppButton(
                          text: 'Enviar',
                          onPressed: () =>
                              bloc.add(TransactionPreviewOnSendPressed()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                child: Row(
                  children: [
                    Expanded(
                        child: AppButton(
                      text: 'Cancelar',
                      color: Colors.red.shade400,
                      onPressed: () =>
                          bloc.add(TransactionPreviewOnCancelPressed()),
                    )),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppText(
              text: 'Dirección de envio',
              textAlign: TextAlign.left,
              size: 22,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.background2,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AppText(text: bloc.address),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const AppText(
              text: 'Cantidad',
              textAlign: TextAlign.left,
              size: 22,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.background2,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AppText(text: '${bloc.amount} ALGO'),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 50,
                      child: AppButton(
                        text: 'Enviar',
                        onPressed: () =>
                            bloc.add(TransactionPreviewOnSendPressed()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Row(
                children: [
                  Expanded(
                      child: AppButton(
                    text: 'Cancelar',
                    color: Colors.red.shade400,
                    onPressed: () =>
                        bloc.add(TransactionPreviewOnCancelPressed()),
                  )),
                ],
              ),
            ),
          ],
        );
      }
    });
  }
}
