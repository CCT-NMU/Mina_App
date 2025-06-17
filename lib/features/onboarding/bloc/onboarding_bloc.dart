import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/data/repositories/cycle_repository.dart';
import 'package:mina_app/data/repositories/user_repository.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingStarted>((event, emit) {
      // TODO: implement event handler
      emit(OnboardingInitial());
    });

    on<OnboardingNameAsked>((event, emit) {
      // TODO: implement event handler
      emit(OnboardingInProgress());
    });

    on<OnboardingNameSubmitted>((event, emit) {
      UserRepository.instance.insertOrUpdateUserSetting('name', event.name);
      emit(OnboardingInProgress());
    });

    on<LastPeriodPickerViewLoaded>((event, emit) {
      emit(OnboardingInProgress());
    });

    on<LastPeriodPickerViewSubmitted>((event, emit) {
      emit(OnboardingInProgress());
    });

    on<OnboardingCompleted>((event, emit) {
      emit(OnboardingComplete());
    });
  }
}
