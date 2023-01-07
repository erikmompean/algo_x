import 'package:algo_x/bloc/send_money_screen_bloc/send_money_state.dart';
import 'package:algo_x/bloc/transaction_list_bloc/transaction_list_bloc.dart';
import 'package:algo_x/bloc/transaction_list_bloc/transaction_list_event.dart';
import 'package:algo_x/bloc/transaction_list_bloc/transaction_list_state.dart';
import 'package:algo_x/locators/app_colors.dart';
import 'package:algo_x/models/transaction_explorer.dart';
import 'package:algo_x/utils/extends/string_extension.dart';
import 'package:algo_x/widgets/app_text.dart';
import 'package:algo_x/widgets/app_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TransactionListBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const AppTopBar(title: 'Transacciones'),
              BlocListener(
                bloc: bloc,
                listener: (context, state) {
                  if (state is TransactionListInitialState) {
                    bloc.add(TransactionListInitEvent());
                  }
                },
                child: BlocBuilder(
                  bloc: bloc,
                  buildWhen: ((previous, current) {
                    return current is! SendMoneyGoBackState &&
                        current is! SendMoneyAddresPagePassedState;
                  }),
                  builder: (context, state) {
                    if (state is TransactionListLoadingState) {
                      return Expanded(
                        child: Center(
                          child: LoadingAnimationWidget.halfTriangleDot(
                              color: Colors.orange, size: 50),
                        ),
                      );
                    } else if (state is TransactionListIdleState) {
                      return transactionList(bloc, state);
                    } else if (state is TransactionListInitialState) {
                      bloc.add(TransactionListInitEvent());
                      return Center(
                        child: LoadingAnimationWidget.halfTriangleDot(
                            color: Colors.orange, size: 50),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionList(
      TransactionListBloc bloc, TransactionListIdleState state) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: state.transacctions.length,
                      itemBuilder: (context, index) {
                        final transaction = state.transacctions[index];
                        return transactionItem(transaction, state);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget transactionItem(
      TransactionExplorer transaction, TransactionListIdleState state) {
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
              color: transaction.imSender(state.account.publicAddress)
                  ? Colors.red.shade400
                  : Colors.green.shade400,
              softWrap: false,
              maxLines: 1,
              textOverflow: TextOverflow.fade,
            ),
          ],
        ),
      ),
    );
  }
}
