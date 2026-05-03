import 'package:fintrack/domain/repositories/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;

  TransactionBloc({required this.repository}) : super(TransactionInitial()) {
    on<LoadTransactions>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions = await repository.getAllTransactions();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });

    on<AddTransaction>((event, emit) async {
      try {
        await repository.addTransaction(event.transaction);
        add(LoadTransactions()); // Тізімді жаңарту
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });

    on<DeleteTransaction>((event, emit) async {
      try {
        await repository.deleteTransaction(event.id);
        add(LoadTransactions());
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });
  }
}
