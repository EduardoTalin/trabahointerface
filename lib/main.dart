import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  void _acessar() {
    String nome = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;

    if (nome.isNotEmpty && email.isNotEmpty && senha.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondPage(
            nome: nome,
            email: email,
            senha: senha,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Por favor, preencha todos os campos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Acesso'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _senhaController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
              ),
              ElevatedButton(
                onPressed: _acessar,
                child: Text('Acessar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final String nome;
  final String email;
  final String senha;

  SecondPage({
    required this.nome,
    required this.email,
    required this.senha,
  });

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool mostrarInformacoes = true;

  void _toggleInformacoes() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Deseja ocultar as informações?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  mostrarInformacoes = !mostrarInformacoes;
                });
                Navigator.of(context).pop();
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nome do Usuário: ${widget.nome}'),
            if (mostrarInformacoes)
              Column(
                children: [
                  Text('Email: ${widget.email}'),
                  Text('Senha: ${widget.senha}'),
                ],
              ),
            ElevatedButton(
              onPressed: _toggleInformacoes,
              child: Text(mostrarInformacoes ? 'Ocultar Informações' : 'Mostrar Informações'),
            ),
          ],
        ),
      ),
    );
  }
}