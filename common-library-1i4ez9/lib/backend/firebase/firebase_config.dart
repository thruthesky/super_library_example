import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAkeUbAY1Eqe1UyXYNuSwgzkoI2NpVp7Yw",
            authDomain: "withcenter-school.firebaseapp.com",
            projectId: "withcenter-school",
            storageBucket: "withcenter-school.appspot.com",
            messagingSenderId: "732860815667",
            appId: "1:732860815667:web:e4d004e27fe73e99efc646",
            measurementId: "G-1FE35J4Q8T"));
  } else {
    await Firebase.initializeApp();
  }
}
