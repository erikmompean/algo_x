import 'package:algo_x/bloc/recover_account_scren_bloc/recover_account_event.dart';
import 'package:algo_x/bloc/recover_account_scren_bloc/recover_account_state.dart';
import 'package:algo_x/repositories/encrypted_prefernces_repository.dart';
import 'package:algo_x/services/purestake_service.dart';
import 'package:algo_x/utils/navigator_service.dart';
import 'package:algo_x/utils/routes.dart';
import 'package:algorand_dart/algorand_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecoverAccountScreenBloc
    extends Bloc<RecoverAccountEvent, RecoverAccountState> {
  List<String> words = [];

  final PureStakeService _pureStakeService;
  final EncryptedPreferencesRepository _encryptedPreferencesRepository;

  RecoverAccountScreenBloc(
      this._pureStakeService, this._encryptedPreferencesRepository)
      : super(RecoverAccountInitialState()) {
    on<RecoverAccountOnNextPressedEvent>(
        (event, emit) => _onNextPressed(event, emit));
    on<RecoverAccountOnBackPressedEvent>(
        (event, emit) => _onBackPressed(event, emit));
    on<RecoverAccountOnRecoverPressedEvent>(
        (event, emit) => _onRecoverPressed(event, emit));
  }

  Future<void> _onNextPressed(RecoverAccountOnNextPressedEvent event,
      Emitter<RecoverAccountState> emit) async {
    var counter = words.length + 1;
    if (event.word.isEmpty) {
      emit(RecoverAccountEmptyWordErrorState(counter));
    } else {
      words.add(event.word);
      counter = words.length + 1;
      if (counter == 26) {
        emit(RecoverAccountResumeState(words));
      } else if (counter == 25) {
        emit(RecoverAccountNextWordState(counter));
      } else {
        emit(RecoverAccountNextWordState(counter));
      }
    }
  }

  Future<void> _onBackPressed(RecoverAccountOnBackPressedEvent event,
      Emitter<RecoverAccountState> emit) async {
    words.removeLast();
    var counter = words.length + 1;
    if (counter == 26) {
      emit(RecoverAccountResumeState(words));
    } else if (counter == 25) {
      emit(RecoverAccountNextWordState(counter));
    } else {
      emit(RecoverAccountNextWordState(counter));
    }
  }

  Future<void> _onRecoverPressed(RecoverAccountOnRecoverPressedEvent event,
      Emitter<RecoverAccountState> emit) async {
    try {
      Account? account = await _pureStakeService.recoverAccount(words);
      if (account != null) {
        await _encryptedPreferencesRepository.saveAccount(account);
        NavigationService.instance.navigateAndSetRoot(Routes.home);
      }
    } catch (ex) {
      if (ex is MnemonicException) {
        emit(RecoverAccountInvalidSeedphraseState());
      }
    }
  }
}
