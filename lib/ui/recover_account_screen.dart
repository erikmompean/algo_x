import 'package:algo_x/bloc/recover_account_scren_bloc/recover_account_event.dart';
import 'package:algo_x/bloc/recover_account_scren_bloc/recover_account_screen_bloc.dart';
import 'package:algo_x/bloc/recover_account_scren_bloc/recover_account_state.dart';
import 'package:algo_x/locators/app_colors.dart';
import 'package:algo_x/widgets/app_button.dart';
import 'package:algo_x/widgets/app_circle_button.dart';
import 'package:algo_x/widgets/app_text.dart';
import 'package:algo_x/widgets/app_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecoverAccountScreen extends StatelessWidget {
  final TextEditingController _addresController = TextEditingController();
  var focusNode = FocusNode();

  RecoverAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RecoverAccountScreenBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state is RecoverAccountWordState) {
            _addresController.text = '';
          } else if (state is RecoverAccountInvalidSeedphraseState) {
            const snackBar = SnackBar(
              content: Text('La frase secreta es invalida'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppTopBar(
                  title: 'Recuperar Cuenta',
                ),
                BlocBuilder(
                  buildWhen: (previous, current) {
                    return current is! RecoverAccountInvalidSeedphraseState;
                  },
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is RecoverAccountWordState) {
                      return Expanded(
                        child: passPage(context, state),
                      );
                    } else if (state is RecoverAccountResumeState) {
                      return Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    const AppText(
                                        text:
                                            'Revisa las palabras y pulsa Recuperar'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 150),
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state.passphrase.length,
                                        itemBuilder: (context, index) {
                                          String word = state.passphrase[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: AppColors.background2,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: AppText(
                                                    text: '${index + 1} - $word'),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    AppButton(
                                      text: 'Recuperar',
                                      onPressed: () => bloc.add(
                                          RecoverAccountOnRecoverPressedEvent()),
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
                    } else {
                      return const Center(
                        child: AppText(
                          text: 'Se ha producido un error',
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget passPage(BuildContext context, RecoverAccountWordState state) {
    final bloc = BlocProvider.of<RecoverAccountScreenBloc>(context);
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const AppText(
          text:
              'Escribe aquí tus palabras secretas en el orden correspondiente.',
          size: 18,
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300),
                child: passTextField(state),
              ),
            ),
          ],
        ),
        BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is RecoverAccountEmptyWordErrorState) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AppText(
                  text: 'Debe rellenar el campo dirección',
                  color: Colors.red.shade400,
                ),
              );
            }

            return Container();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: state.wordCount > 1,
              child: AppCircleButton(
                icon: Icons.keyboard_arrow_left,
                size: 26,
                onPressed: () => bloc.add(RecoverAccountOnBackPressedEvent()),
              ),
            ),
            const Spacer(),
            AppButton(
              text: 'Siguiente Palabra',
              textSize: 15,
              onPressed: () {
                bloc.add(
                    RecoverAccountOnNextPressedEvent(_addresController.text));
                focusNode.requestFocus();
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget passTextField(RecoverAccountWordState state) {
    return TextField(
      controller: _addresController,
      focusNode: focusNode,
      cursorColor: AppColors.primary,
      style: const TextStyle(color: AppColors.text),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        filled: true,
        fillColor: AppColors.background2,
        labelStyle: const TextStyle(color: AppColors.secondary),
        hintStyle: const TextStyle(color: Colors.green),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(25.0),
        ),
        labelText: 'Palabra Numero ${state.wordCount}',
        floatingLabelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
