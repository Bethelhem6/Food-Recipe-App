part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationGets extends NotificationEvent {
  final NotificationParam param;
  const NotificationGets({required this.param});
  @override
  List<Object> get props => [];
}

class NotificationGetsMore extends NotificationEvent {
  final NotificationParam param;
  const NotificationGetsMore({required this.param});
  @override
  List<Object> get props => [];
}
