import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final String phoneNumber;
  final String otp;
  final List<String> selectedInterests;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final int? selectedAvatar;

  AuthState({
    this.phoneNumber = '',
    this.otp = '',
    this.selectedInterests = const [],
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.selectedAvatar,
  });

  AuthState copyWith({
    String? phoneNumber,
    String? otp,
    List<String>? selectedInterests,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    int? selectedAvatar,
  }) {
    return AuthState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      selectedInterests: selectedInterests ?? this.selectedInterests,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      selectedAvatar: selectedAvatar ?? this.selectedAvatar,
    );
  }
}

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState();
  }

  void setPhoneNumber(String number) {
    state = state.copyWith(phoneNumber: number);
  }

  void setOtp(String otp) {
    state = state.copyWith(otp: otp);
  }

  void toggleInterest(String interest) {
    final interests = List<String>.from(state.selectedInterests);
    if (interests.contains(interest)) {
      interests.remove(interest);
    } else {
      interests.add(interest);
    }
    state = state.copyWith(selectedInterests: interests);
  }

  void setFirstName(String firstName) {
    state = state.copyWith(firstName: firstName);
  }

  void setLastName(String lastName) {
    state = state.copyWith(lastName: lastName);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setSelectedAvatar(int? avatarIndex) {
    state = state.copyWith(selectedAvatar: avatarIndex);
  }
}

final authProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
