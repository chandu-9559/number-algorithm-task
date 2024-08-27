import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Grid',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Number Grid',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.deepPurple[300],
          ),
          body: NumberGrid(),
        ),
      ),
    );
  }
}


class NumberGrid extends StatefulWidget {
  @override
  _NumberGridState createState() => _NumberGridState();
}

class _NumberGridState extends State<NumberGrid> {
  String selectedRule = 'Odd Numbers';

  List<int> generateNumbers() {
    return List<int>.generate(100, (index) => index + 1);
  }

  bool isOdd(int number) => number % 2 != 0;
  bool isEven(int number) => number % 2 == 0;

  bool isPrime(int number) {
    if (number < 2) return false;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  bool isFibonacci(int number) {
    int a = 0, b = 1, temp;
    while (b < number) {
      temp = a;
      a = b;
      b = temp + b;
    }
    return number == b || number == 0;
  }

  @override
  Widget build(BuildContext context) {
    List<int> numbers = generateNumbers();

    return Column(
      children: [
        SizedBox(height: 20),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.deepPurple, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: DropdownButton<String>(
            value: selectedRule,
            items: <String>['Odd Numbers', 'Even Numbers', 'Prime Numbers', 'Fibonacci Numbers']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple,
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedRule = newValue!;
              });
            },
            dropdownColor: Colors.white,
            icon: Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
            underline: SizedBox(),  // Removes the default underline
          ),
        ),

        SizedBox(height: 20),

        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 9,
              childAspectRatio: 1.0,
            ),
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              int number = numbers[index];
              bool highlight = false;
              if (selectedRule == 'Odd Numbers' && isOdd(number)) highlight = true;
              if (selectedRule == 'Even Numbers' && isEven(number)) highlight = true;
              if (selectedRule == 'Prime Numbers' && isPrime(number)) highlight = true;
              if (selectedRule == 'Fibonacci Numbers' && isFibonacci(number)) highlight = true;

              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  gradient: highlight
                      ? LinearGradient(colors: [Colors.orangeAccent, Colors.redAccent])
                      : LinearGradient(colors: [Colors.grey[300]!, Colors.grey[400]!]),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: highlight
                      ? [BoxShadow(color: Colors.black45, blurRadius: 10, spreadRadius: 1)]
                      : [BoxShadow(color: Colors.grey[500]!, blurRadius: 5, spreadRadius: 1)],
                ),
                child: Center(
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: highlight ? Colors.white : Colors.black54,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
