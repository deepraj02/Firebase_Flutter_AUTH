import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        backgroundColor: Colors.teal[500],
        title: Text("Google-SignIn Demo"),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: _signInWithGoogle,
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Text(
                  "Sign-In with Google",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              color: Color.fromARGB(255, 192, 46, 46),
            )
          ],
        ),
      ),
    );
  }
}

_signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

  final User? user = (await firebaseAuth.signInWithCredential(credential)).user;
}
