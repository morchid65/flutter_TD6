import 'dart:io';
import 'package:flutter/material.dart';
import 'package:providers/favoris_provider.dart';
import 'package:providers/serie_provider.dart.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'router.dart';

// TODO étape 3 : importer SerieProvider
// TODO étape 5 : importer FavorisProvider
// TODO étape 8 : importer WatchlistProvider

void main() {
  runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => SerieProvider()), 
        ChangeNotifeirProvider(create: (_) => FavorisProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SérieListe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
