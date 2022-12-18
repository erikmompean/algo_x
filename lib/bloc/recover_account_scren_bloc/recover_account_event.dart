abstract class RecoverAccountEvent {}

class RecoverAccountOnNextPressedEvent extends RecoverAccountEvent {
  String word;
  RecoverAccountOnNextPressedEvent(this.word);
}

class RecoverAccountOnBackPressedEvent extends RecoverAccountEvent {}

class RecoverAccountOnRecoverPressedEvent extends RecoverAccountEvent {}
