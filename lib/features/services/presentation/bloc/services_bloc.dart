import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_wash/features/services/domain/usecases/get_services.dart';
import 'package:car_wash/features/services/presentation/bloc/services_event.dart';
import 'package:car_wash/features/services/presentation/bloc/services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final GetServices getServices;

  ServicesBloc({required this.getServices}) : super(ServicesInitial()) {
    on<FetchServices>(_onFetchServices);
  }

  Future<void> _onFetchServices(FetchServices event, Emitter<ServicesState> emit) async {
    emit(ServicesLoading());
    try {
      final services = await getServices(event.carWashId);
      emit(ServicesLoaded(services: services));
    } catch (e) {
      emit(ServicesError(message: e.toString()));
    }
  }
}