abstract class TransactionPreviewScreenState {}

class TransactionPreviewLoadingState extends TransactionPreviewScreenState {}

class TransactionPreviewInitState extends TransactionPreviewScreenState {}

class TransactionPreviewGoBackState extends TransactionPreviewScreenState {}

class TransactionPreviewAcceptedPaymentState
    extends TransactionPreviewScreenState {
  final String transactionId;

  TransactionPreviewAcceptedPaymentState(this.transactionId);
}

class TransactionPreviewErrorState extends TransactionPreviewScreenState {}
