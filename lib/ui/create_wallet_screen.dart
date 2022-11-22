import 'package:crypto_x/bloc/create_wallet_screen_bloc/create_wallet_screen_bloc.dart';
import 'package:crypto_x/bloc/create_wallet_screen_bloc/create_wallet_screen_event.dart';
import 'package:crypto_x/bloc/create_wallet_screen_bloc/create_wallet_screen_state.dart';
import 'package:crypto_x/locators/app_colors.dart';
import 'package:crypto_x/ui/create_wallet_pages/first_page.dart';
import 'package:crypto_x/ui/create_wallet_pages/word_page.dart';
import 'package:crypto_x/utils/navigator_service.dart';
import 'package:crypto_x/utils/routes.dart';
import 'package:crypto_x/widgets/app_button.dart';
import 'package:crypto_x/widgets/app_text.dart';
import 'package:crypto_x/widgets/app_top_bar.dart';
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
      floatingActionButton: FloatingActionButton(onPressed: () => _pageController.jumpToPage(25),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const AppTopBar(),
            BlocListener(
              bloc: bloc,
              listener: (context, state) {
                if(state is FinishedCreateAccountState) {
                  NavigationService.instance.navigateToReplacement(Routes.home);
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
                    pages.addAll(generateWords(state.seedPhrase));
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

  Widget lastPage(BuildContext context) {
    return Column(
      children: [
        const AppText(text: 'bla bla bla bla'),
        const SizedBox(
          width: 20,
        ),
        AppButton(
          text: 'Next',
          onPressed: () => BlocProvider.of<CreateWalletScreenBloc>(context).add(FinishedCreateEvent()),
        ),
      ],
    );
  }
}
