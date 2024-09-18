part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

/////////////////////////////////////////////////////////////////////
/// register passenger
class NotificationGetsLoading extends NotificationState {}

class NotificationGetsSuccess extends NotificationState {
  final List<NotificationModel> notifiacations;
  const NotificationGetsSuccess({required this.notifiacations});
}

class NotificationGetsFaulire extends NotificationState {
  final Failure failure;
  const NotificationGetsFaulire({required this.failure});
}

/////////////////////////////////////////////////////////////////////
/// get more notifications
class NotificationGetsMoreLoading extends NotificationState {}

class NotificationGetsMoreSuccess extends NotificationState {
  final List<NotificationModel> notifiacations;
  const NotificationGetsMoreSuccess({required this.notifiacations});
}

class NotificationGetsMoreFaulire extends NotificationState {
  final Failure failure;
  const NotificationGetsMoreFaulire({required this.failure});
}
