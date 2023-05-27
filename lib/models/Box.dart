import 'package:flutter/material.dart';
import 'package:trail_run/constants.dart';

class RoundedRectangularBox extends StatelessWidget {
  final num number;
  final double size;
  final String additionalText;
  final VoidCallback onpress;

  RoundedRectangularBox({required this.number, required this.size, required this.additionalText, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kMainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleBox(number: number, size: size),
            SizedBox(height: 10),
            Text(
              additionalText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}

class CircleBox extends StatelessWidget {
  final num number;
  final double size;

  CircleBox({required this.number, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class newRoundedRectangularBox extends StatelessWidget {
  final String data;
  final String additionalText;
  final VoidCallback onpress;

  newRoundedRectangularBox({required this.data, required this.additionalText, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kMainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // newCircleBox(data: data, size: size),
            Text(data, style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),),
            SizedBox(height: 10),
            Text(
              additionalText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15,),

          ],
        ),
      ),
    );
  }
}

class iconRoundedRectangularBox extends StatelessWidget {
  final String symbol;
  final double size;
  final String additionalText;
  final VoidCallback onpress;

  iconRoundedRectangularBox({required this.symbol, required this.size, required this.additionalText, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kMainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconCircleBox(symbol: symbol, size: size),
            SizedBox(height: 10),
            Text(
              additionalText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15,),

          ],
        ),
      ),
    );
  }
}
class iconCircleBox extends StatelessWidget {
  final String symbol;
  final double size;

  iconCircleBox({required this.symbol, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            color: Colors.black,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
