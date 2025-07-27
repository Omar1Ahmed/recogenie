import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: 'https://kkllntsdctvnypiezmfz.supabase.co', anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtrbGxudHNkY3R2bnlwaWV6bWZ6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM1NTYwMTQsImV4cCI6MjA2OTEzMjAxNH0.omWRI8KqG72LELRJkCu-QOr8C7QqpeN2qcUbiYk-3HI');
  await Firebase.initializeApp(
    name: 'Recogenie',
    options: FirebaseOptions(
        apiKey: 'AIzaSyAbehGFZKiL_sdQc92sp0bw1t93igdkK00', appId: '1:428070339741:android:ffc0c53191ff3a4a0b4074', messagingSenderId: '428070339741', projectId: 'recogenie-18f45'),
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {


    signUp('omar@gmail.com','1234567');
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
   lol(String uid) async {
 await Supabase.instance.client.schema('public').from('cart').select('*').eq('user_id', uid);
    // print(lol);
     // final response = await Supabase.instance.client
     //     .from('cart')
     //     .select('*').eq('user_id', uid);
     // print(response);

   }

  Future<void> signUp(String email, String password) async {
    try {
 await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

    } on FirebaseAuthException {

      signIn(email, password);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
 await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  final user = FirebaseAuth.instance.currentUser;
      final token = user?.uid;


      lol(token!);

    } on FirebaseAuthException {
      // print('Error: ${e.message}');
    }
  }
}
