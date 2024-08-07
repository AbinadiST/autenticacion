

//! 1 - State del provider

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class LoginFormState {

  final bool isPosting;
  final bool isFormPosted; //para saber si la persona intentó POSTEARLA y ver si hay errores
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
  this.isPosting = false, 
  this.isFormPosted = false, 
  this.isValid = false, 
  this.email = const Email.pure(), 
  this.password = const Password.pure()
  });

  LoginFormState copyWith({

    bool? isPosting,     // la hacer transacción y es asincronica y verificar usuario
    bool? isFormPosted,  // usuario da clic en INGRESAR y mostrar errores en en LOGIN
    bool? isValid,
    Email? email,
    Password? password,

  }) => LoginFormState(

    //* si tenemos algunos estos valores será igual a ese valor y si no será al valor que tengamos en el estado

    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,

  );

  @override
  String toString() {
    return '''
      LoginFormState:
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      email: $email
      password: $password
  ''';

  }

}


//! 2 - Como implementamos un notifier

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier(): super( LoginFormState() );

  onEmailChange( String value ) {

    final newEmail = Email.dirty( value );
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([ newEmail, state.password ]) // enviará estos INPUTS: NEWEMAIL, STATE.PASSWORD para validar
    );

  }

  onPasswordChanged( String value ) {

    final newPassword = Password.dirty( value );
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([ newPassword, state.email ]) // enviará estos INPUTS: NEWEMAIL, STATE.PASSWORD para validar
    );
  }

  onFormSubmit(){
    _touchEveryField();

    if ( !state.isValid ) return;

    print( state ); //imprime el TOSTRING() que creamos arriba 
  }

  _touchEveryField() { // manoseará cada campo para ver errores 

    final email = Email.dirty( state.email.value );
    final password = Password.dirty( state.password.value );

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([ email, password])
    );

  }

}

//! 3 - StateNotifierProvider - consume afuera 

final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>(((ref) {
  
  return LoginFormNotifier();
  
}
));