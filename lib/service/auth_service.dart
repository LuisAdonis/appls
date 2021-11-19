import 'package:appls/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSingin = GoogleSignIn();
  GoogleSignInAccount? _user;
  //create user obj from firebase user
  GoogleSignInAccount get usera => _user!;

  Future googleLogin() async {
    final googleusers = await googleSingin.signIn();
    if (googleusers == null) return;
    _user = googleusers;
    final googleAut = await googleusers.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAut.accessToken,
      idToken: googleAut.idToken,
    );

    final data = await FirebaseAuth.instance.signInWithCredential(credential);
    return _userFromFirebase(data.user!);
  }

  UserModel? _userFromFirebase(User user) {
    return UserModel(
      userId: user.uid,
      name: user.displayName,
      email: user.email,
      photoURL: user.photoURL,
    );
  }

  //auth changes user stream

  Stream<UserModel?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebase(user!));
  }

  Future signinAnon() async {
    try {
      UserCredential cred = await _auth.signInAnonymously();
      User? user = cred.user;
      // print(user);
      return _userFromFirebase(user!);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }
  // SIGN UP WITH EMAIL AND PASSWORD

  Future signUpWithEmailPassword({required String email, required String name, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _auth.currentUser!.updateDisplayName(name);
      await _auth.currentUser!.updatePhotoURL(
          "https://firebasestorage.googleapis.com/v0/b/app-lsec.appspot.com/o/85622928-icono-de-perfil-de-avatar-predeterminado-marcador-de-posici%C3%B3n-de-foto-gris-vectores-de-ilustraciones.jpg?alt=media&token=ac3bf05d-6b29-4ab8-97d1-b21934ccadf4");

      User? user = _auth.currentUser;
      return _userFromFirebase(user!);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  //sign in  with email and password

  Future signinUsingEmailPassword(String email, String pass) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User? user = cred.user;
      return _userFromFirebase(user!);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  Future resetPassword({required String email}) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
