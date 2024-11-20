import 'package:flutter/material.dart';
import 'package:drawer/menu_lateral.dart';

class DispositionScreen extends StatelessWidget {
  const DispositionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disposición en pantalla'),
      ),
      drawer: const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/pattern.png'),
                repeat: ImageRepeat.repeat)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/pikachu.png',
                        width: 100, height: 100),
                    const Text('Pikachu', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/squirtle.png',
                        width: 100, height: 100),
                    const Text('Squirtle', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/charmander.png',
                        width: 105, height: 105),
                    const Text('Charmander', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/bulbasaur.png',
                        width: 100, height: 100),
                    const Text('Bulbasaur', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/eevee.png',
                        width: 100, height: 100),
                    const Text('Eevee', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/meowth.png',
                        width: 100, height: 100),
                    const Text('Meowth', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
