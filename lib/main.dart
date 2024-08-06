import 'package:flutter/material.dart';
import 'package:flutter_google_ai/chat_page.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = 'AIzaSyAcQB9uol3yreaLo87_7FZ5xQ0QtFepC2M';

void main() {
  //async {
//   final model = GenerativeModel(
//     model: 'gemini-1.5-flash-latest',
//     apiKey: apiKey,
//   );

//   const prompt = 'Write a story about a magic backpack.';
//   final content = [Content.text(prompt)];
//   final response = await model.generateContent(content);

//   print(response.text);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner DEBUG
      title: 'Flutter Demo',
      theme: ThemeData(
        // Konfigurasi tema aplikasi
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 118, 39, 255)),
        useMaterial3: true, // Mengaktifkan Material Design 3
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      home: const ChatPage(), // Halaman utama aplikasi
    );
  }
}
