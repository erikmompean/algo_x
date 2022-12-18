abstract class RecoverAccountState {}

class RecoverAccountInvalidSeedphraseState extends RecoverAccountState {}

abstract class RecoverAccountWordState extends RecoverAccountState {
  int wordCount;
  RecoverAccountWordState(this.wordCount);
}

class RecoverAccountInitialState extends RecoverAccountWordState {
  RecoverAccountInitialState() : super(1);
}

class RecoverAccountNextWordState extends RecoverAccountWordState {
  RecoverAccountNextWordState(super.wordCounter);
}

class RecoverAccountLastWordState extends RecoverAccountWordState {
  RecoverAccountLastWordState(super.wordCounter);
}

class RecoverAccountEmptyWordErrorState extends RecoverAccountWordState {
  RecoverAccountEmptyWordErrorState(super.wordCounter);
}

class RecoverAccountResumeState extends RecoverAccountState {
  List<String> passphrase;

  RecoverAccountResumeState(this.passphrase);
}
