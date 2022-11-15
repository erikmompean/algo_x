import 'package:crypto_x/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeScreenBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              onPressed: bloc.createWallet,
              child: const Text('Crear una wallet'),
            ),
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
