import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/article_model.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;

  ArticleScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dividindo o conteúdo em parágrafos, baseados em quebras de linha.
    List<String> paragrafos = article.content.split('\n');

    return Scaffold(
      appBar: AppBar(
        title: Text('Artigo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Imagem do artigo
              if (article.imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: article.imageUrl,
                    width: double.infinity,
                    height: screenHeight * 0.3,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              SizedBox(height: 20),

              // Título do artigo
              Text(
                article.title,
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Data de publicação
              Text(
                'Publicado em: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(article.publishedDate))}',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),

              // Exibindo os conteudos formatados
              for (String paragrafo in paragrafos)
                if (paragrafo.trim().startsWith(RegExp(r'^\d+\.\s'))) ...[
                   // Se o parágrafo começar com um número seguido de ponto e espaço (lista numerada)
                  Text(
                    paragrafo.trim(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold, // Para destacar itens numerados
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 10),
                ] else if (paragrafo.trim().isNotEmpty) ...[
                  // Para renderizar os paragrafos normais
                  Text(
                    paragrafo.trim(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 15), // Espaçamento entre parágrafos
                ],

              // Botão Fechar
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Fecha a tela ao clicar
                  },
                  child: Text('Fechar'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
