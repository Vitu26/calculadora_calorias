import 'package:calculo_calorias/components/action_button.dart';
import 'package:calculo_calorias/components/custom_appbar.dart';
import 'package:calculo_calorias/models/article_model.dart';
import 'package:flutter/material.dart';
import 'article_screen.dart';
import '../services/article_service.dart';
import 'input_screen.dart'; // Importa a tela de entrada

class ResultScreen extends StatefulWidget {
  final String resultado;

  ResultScreen({required this.resultado});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Future<List<Article>> _articles;

  @override
  void initState() {
    super.initState();
    _articles = ArticleService.fetchArticles();
  }

  void _mostrarArtigo(Article article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ArticleScreen(article: article),
    );
  }

  // Método para navegar de volta à tela de entrada
  void _novoCalculo() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              InputScreen()), // Redireciona para a tela de entrada
    );
  }

  @override
  Widget build(BuildContext context) {
    // Adapta o tamanho do texto ao tamanho da tela
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(title: 'Resultado'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Destaque para o resultado de calorias
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50, // Fundo suave para destaque
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  widget.resultado,
                  style: TextStyle(
                    fontSize: screenWidth * 0.07, // Texto grande e em destaque
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent, // Cor de destaque
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Título da lista de artigos relacionados
            Text(
              'Artigos Relacionados:',
              style: TextStyle(
                fontSize: screenWidth * 0.05, // Texto adaptável
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Listagem de artigos relacionados
            Expanded(
              child: FutureBuilder<List<Article>>(
                future: _articles,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Indicador de carregamento
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'Erro ao carregar artigos')); // Tratamento de erro
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text(
                            'Nenhum artigo encontrado')); // Caso não tenha artigos
                  }

                  final articles = snapshot.data!;
                  return ListView.separated(
                    itemCount: articles.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return ListTile(
                        leading: Icon(Icons.article, color: Colors.blueAccent),
                        title: Text(
                          article.title,
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () => _mostrarArtigo(article),
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            Center(
                child: ActionButton(
                    text: "Fazer outro Cálculo", onPressed: _novoCalculo)),
          ],
        ),
      ),
    );
  }
}
