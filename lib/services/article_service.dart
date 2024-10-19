import 'dart:convert';
import 'package:calculo_calorias/models/article_model.dart';
import 'package:http/http.dart' as http;


class ArticleService {
  static Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse('https://api.npoint.io/cd5cc92e412c4058c90d'));

      if (response.statusCode == 200) {
        // Decodifica o corpo da resposta
        final data = json.decode(response.body);

        // Verifica se o campo 'articles' existe no JSON
        if (data['articles'] != null) {
          List<dynamic> articlesJson = data['articles'];

          return articlesJson.map((article) => Article.fromJson(article)).toList();
        } else {
          throw Exception('Campo "articles" não encontrado no JSON');
        }
      } else {
        throw Exception('Erro ao buscar dados da API. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao carregar artigos: $e');
    }
  }
}
