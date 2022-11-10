import 'package:crypto_x/bloc/bloc_files/bloc_provider.dart';
import 'package:crypto_x/bloc/home_screen_bloc.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeScreenBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: bloc.initializeAlgorand,
              child: const Text('Inicializar'),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // ElevatedButton(
            //   onPressed: bloc.createWallet,
            //   child: const Text('Crear Wallet'),
            // ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: bloc.loadAccounts,
              child: const Text('Cargar todas las wallets'),
            ),
            // ElevatedButton(
            //   onPressed: bloc.loadFirstAccount,
            //   child: const Text('Cargar Wallet 1'),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // ElevatedButton(
            //   onPressed: bloc.loadSecondAccount,
            //   child: const Text('Cargar Wallet 2'),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: bloc.sendTransaction,
              child: const Text('Enviar transaccion'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: bloc.debug,
              child: const Text('Debugar'),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildWallets() {
  //   return StreamBuilder<Map<int,dynamic>>(
  //     stream: bloc,
  //     builder: ,
  //   );
  // }
}
