import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app_bloc/application/features/auth/model/user_model.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<CheckLoginStatusEvent>((event, emit) async {
      User? user;
      try {
        Future.delayed(const Duration(seconds: 2), () {
          user = _auth.currentUser;
        });
        // check the login status
        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthenticationError(message: e.toString()));
      }
    });

    //logic for the signup event
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final UserCredential = await _auth.createUserWithEmailAndPassword(
            email: event.user.email.toString(),
            password: event.user.password.toString());

        final user = UserCredential.user;
        if (user != null) {
          FirebaseFirestore.instance.collection("users").doc(user.uid).set({
            //set the data for storing to friestore
            'uid': user.uid,
            'email': user.email,
            'name': event.user.name,
            'phone': event.user.phone,
            'createdAt': DateTime.now()
          });
          emit(Authenticated(user: user));
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthenticationError(message: e.toString()));
      }
    });

    //bloclogic for login

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final UserCredential = await _auth.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        final user = UserCredential.user;
        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthenticationError(message: e.toString()));
      }
    });

    //bloc logic for logout
    on<LogOutEvent>((event, emit) async {
      try {
        await _auth.signOut();
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthenticationError(message: e.toString()));
      }
    });
  }
}
