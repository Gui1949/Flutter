import 'package:flutter/material.dart'; //Importar o dart
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerador de Nome de Startup',
      home: PalavrasAleatorias(),
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        colorScheme: ColorScheme.dark()

      ),
    );
  }
}

class PalavrasAleatorias extends StatefulWidget {
  const PalavrasAleatorias({Key? key}) : super(key: key);

  @override
  _PalavrasAleatoriasState createState() => _PalavrasAleatoriasState();
}

class _PalavrasAleatoriasState extends State<PalavrasAleatorias> {
  @override
  void _apertadoSalvo() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      final tiras = _salvo.map(
        (WordPair pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _fonteMaior,
            ),            
          );
        },
      );

      final dividido = ListTile.divideTiles(
        context: context,
        tiles: tiras,
      ).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('Nomes Salvos'),
        ),
        body: ListView(
          children: dividido,
        ),
      );
    }));
  }

  final _sugestoes = <WordPair>[];
  final _salvo = <WordPair>{};
  final _fonteMaior = const TextStyle(fontSize: 18.0);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de Nome de Startup'),
        actions: [
          IconButton(onPressed: _apertadoSalvo, icon: Icon(Icons.list))
        ],
      ),
      body: _buildSugestoes(),
    );
  }

  Widget _buildSugestoes() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _sugestoes.length) {
            _sugestoes.addAll(generateWordPairs().take(10));
          }
          return _buildLinha(_sugestoes[index]);
        });
  }

  Widget _buildLinha(WordPair pair) {
    final jaSalvo = _salvo.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _fonteMaior,
      ),
      trailing: Icon(
        jaSalvo ? Icons.favorite : Icons.favorite_border,
        color: jaSalvo ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (jaSalvo) {
            _salvo.remove(pair);
          } else {
            _salvo.add(pair);
          }
        });
      },
    );
  }
}
