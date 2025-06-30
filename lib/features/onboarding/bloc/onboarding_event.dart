part of 'onboarding_bloc.dart';

sealed class OboardingEvent extends Equatable {
  const OboardingEvent();

  @override
  List<Object> get props => [];
}

class OnboardingStarted extends OboardingEvent {}

class OnboardingNameAsked extends OboardingEvent {}

class OnboardingNameSubmitted extends OboardingEvent {}

class LastPeriodPickerViewLoaded extends OboardingEvent {}

class LastPeriodPickerViewSubmitted extends OboardingEvent {
  LastPeriodPickerViewSubmitted();
}

class OnboardingCompleted extends OboardingEvent {}
