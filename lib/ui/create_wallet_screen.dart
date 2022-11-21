import 'package:crypto_x/bloc/create_wallet_screen_bloc/create_wallet_screen_bloc.dart';
import 'package:crypto_x/bloc/create_wallet_screen_bloc/create_wallet_screen_state.dart';
import 'package:crypto_x/locators/app_colors.dart';
import 'package:crypto_x/ui/create_wallet_pages/first_page.dart';
import 'package:crypto_x/ui/create_wallet_pages/word_page.dart';
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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const AppTopBar(),
            BlocBuilder(
              bloc: BlocProvider.of<CreateWalletScreenBloc>(context),
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
}
