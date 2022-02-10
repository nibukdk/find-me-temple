import 'package:flutter/material.dart';

class OnboardScreenTwo extends StatelessWidget {
  const OnboardScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            // height: 400,
            width: double.infinity,
            color: const Color.fromARGB(255, 255, 209, 166),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/onbaord/FindVenues.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 200,
                  right: 160,
                  child: ElevatedButton(
                    onPressed: () => print("object pressed"),
                    child: Text(
                      "Next",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
