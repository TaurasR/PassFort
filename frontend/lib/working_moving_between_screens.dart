import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  bool goToNextPage = false;

  @override
  Widget build(BuildContext context) {
    if (!goToNextPage) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'First page',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    goToNextPage = true;
                  });
                },
                child: const Text(
                  'Go to page 2',
                ),
              ),
            ],
          ),
        ),
      );
    }
    return const SecondPage();
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPage();
}

class _SecondPage extends State<SecondPage> {
  bool goToNextPage = false;

  @override
  Widget build(BuildContext context) {
    if (!goToNextPage) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Second page',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    goToNextPage = true;
                  });
                },
                child: const Text(
                  'Go to page 1',
                ),
              ),
            ],
          ),
        ),
      );
    }
    return const FirstPage();
  }
}
