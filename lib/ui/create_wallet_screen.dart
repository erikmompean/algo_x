import 'package:algo_x/bloc/create_wallet_screen_bloc/create_wallet_screen_bloc.dart';
import 'package:algo_x/bloc/create_wallet_screen_bloc/create_wallet_screen_event.dart';
import 'package:algo_x/bloc/create_wallet_screen_bloc/create_wallet_screen_state.dart';
import 'package:algo_x/locators/app_colors.dart';
import 'package:algo_x/ui/create_wallet_pages/first_page.dart';
import 'package:algo_x/ui/create_wallet_pages/word_page.dart';
import 'package:algo_x/utils/navigator_service.dart';
import 'package:algo_x/utils/routes.dart';
import 'package:algo_x/widgets/app_button.dart';
import 'package:algo_x/widgets/app_text.dart';
import 'package:algo_x/widgets/app_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CreateWalletScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  CreateWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var bloc = BlocProvider.of<CreateWalletScreenBloc>(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _pageController.jumpToPage(25),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const AppTopBar(
              title: 'Crear Cartera',
            ),
            BlocListener(
              bloc: bloc,
              listener: (context, state) async {
                if (state is FinishedCreateAccountState) {
                  await NavigationService.instance
                      .navigateAndSetRoot(Routes.home);
                }
              },
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is CreateWalletInitState) {
                    return Center(
                      child: LoadingAnimationWidget.halfTriangleDot(
                          color: Colors.orange, size: 50),
                    );
                  } else if (state is CreateWalletIdle) {
                    List<Widget> pages = [];
                    pages.add(firstPage());
                    pages.add(middlePage(state));
                    // pages.addAll(generateWords(state.seedPhrase));
                    pages.add(lastPage(context));
                    return Expanded(
                      child: PageView(
                        controller: _pageController,
                        children: pages,
                      ),
                    );
                  }
                  return Center(
                    child: LoadingAnimationWidget.halfTriangleDot(
                        color: AppColors.primary, size: 50),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget firstPage() {
    return FirstPage(pageController: _pageController);
  }

  List<Widget> generateWords(List<String> seedPhrase) {
    List<Widget> pages = [];
    var count = 1;
    for (var word in seedPhrase) {
      Widget page = WordPage(
        pageController: _pageController,
        wordNumber: count,
        word: word,
      );

      pages.add(page);
      count++;
    }
    return pages;
  }

  Widget middlePage(CreateWalletIdle state) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const AppText(
                  text:
                      'Apunta las siguientes palabras. A poder ser que este sea un medio fisico como una libreta o una hoja.',
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.seedPhrase.length,
                    itemBuilder: (context, index) {
                      String word = state.seedPhrase[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.background2,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: AppText(text: '$index - $word'),
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
                  text: 'Siguiente',
                  onPressed: () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget lastPage(BuildContext context) {
    return Column(
      children: [
        const AppText(
            text:
                'Ahora guarda bien estas palabras, recuerda si las pierdes no podrás recuperar la cuenta.'),
        const SizedBox(
          height: 20,
        ),
        AppButton(
          text: 'Finalizar',
          onPressed: () => BlocProvider.of<CreateWalletScreenBloc>(context)
              .add(FinishedCreateEvent()),
        ),
      ],
    );
  }
}
