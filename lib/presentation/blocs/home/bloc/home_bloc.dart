import 'package:bloc/bloc.dart';
import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TransactionRepository repository;

  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<HomeLoadRequested>((event, emit) async {
      emit(HomeLoading());
      try {
        final txs = await repository.getAllTransactions();
        final income = txs
            .where((e) => e.type == TransactionType.income)
            .fold<double>(0, (p, e) => p + e.amount);
        final expense = txs
            .where((e) => e.type == TransactionType.expense)
            .fold<double>(0, (p, e) => p + e.amount);
        final recent = [...txs]..sort((a, b) => b.date.compareTo(a.date));
        emit(
          HomeLoaded(
            income: income,
            expense: expense,
            balance: income - expense,
            recentTransactions: recent.take(3).toList(),
          ),
        );
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}

