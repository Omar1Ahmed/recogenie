import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordVisibilityCubit extends Cubit<bool> {
  PasswordVisibilityCubit() : super(true); // Password is hidden by default

  void toggleVisibility() => emit(!state);
}