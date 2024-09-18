

import 'package:emebet/core/utils/injections.dart';
import 'package:emebet/features/auth/presentaion/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers() {
  return [
    BlocProvider<AuthBloc>(
      create: (context) => sl(),
    ),
   
  ];
}
