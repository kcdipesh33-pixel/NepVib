
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl =
    'https://lndccppuotupxycbzifx.supabase.co';

// यहाँ आफ्नो sb_publishable_ key राख
const supabaseKey = 'PASTE_YOUR_PUBLISHABLE_KEY_HERE';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(const NepVibApp());
}

class NepVibApp extends StatelessWidget {
  const NepVibApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NepVib',
      theme: ThemeData.dark(),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLogin = true;
  bool loading = false;

  Future<void> authenticate() async {
    if (email.text.trim().isEmpty ||
        password.text.length < 6) {
      showMessage('Email राख र Password कम्तीमा ६ अक्षरको बनाऊ।');
      return;
    }

    setState(() => loading = true);

    try {
      final auth = Supabase.instance.client.auth;

      if (isLogin) {
        await auth.signInWithPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
      } else {
        await auth.signUp(
          email: email.text.trim(),
          password: password.text.trim(),
        );
      }

      if (!mounted) return;

      if (isLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomePage(),
          ),
        );
      } else {
        showMessage(
          'Account बन्यो! Email verification गर्नुपर्ने हुन सक्छ।',
        );
      }
    } on AuthException catch (e) {
      showMessage(e.message);
    } catch (e) {
      showMessage('Error: $e');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const Text(
                'NepVib 🇳🇵',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
              const Text('Watch • Create • Earn'),
              const SizedBox(height: 40),

              Text(
                isLogin ? 'Welcome Back!' : 'Create Account',
                style: const TextStyle(fontSize: 25),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: loading ? null : authenticate,
                  child: loading
                      ? const CircularProgressIndicator()
                      : Text(isLogin ? 'LOGIN' : 'SIGN UP'),
                ),
              ),

              TextButton(
                onPressed: () {
                  setState(() => isLogin = !isLogin);
                },
                child: Text(
                  isLogin
                      ? 'Create New Account'
                      : 'Already have an account? Login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NepVib 🇳🇵'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const AuthPage(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to NepVib!',
              style: TextStyle(fontSize: 27),
            ),
            Text('Watch • Create • Earn 🇳🇵'),
          ],
        ),
      ),
    );
  }
}
