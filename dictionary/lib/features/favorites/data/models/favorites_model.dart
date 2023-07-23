import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../../words/data/models/response_word_model.dart';
import '../../domain/entities/favorites.dart';

@Entity(tableName: 'Favorites')
class FavoritesModel extends Equatable {
  @primaryKey
  final String? word;
  final bool? favorited;
  final ResponseWordModel? response;

  const FavoritesModel({
    this.word,
    this.favorited,
    this.response,
  });

  static Map<String, dynamic> toJson(FavoritesModel e) {
    return {
      'word': e.word,
      'favorited': e.favorited,
      'response': ResponseWordModel.toJson(e.response),
    };
  }

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    return FavoritesModel(
      word: json['word'],
      favorited: json['favorited'],
      response: ResponseWordModel.fromJson(json['response']),
    );
  }

  factory FavoritesModel.fromEntity(Favorites entity) => FavoritesModel(
        word: entity.word,
        favorited: entity.favorited,
        response: ResponseWordModel.fromEntity(entity.responseWord),
      );

  Favorites toEntity() => Favorites(
        word: word,
        favorited: favorited,
        responseWord: response?.toEntity(),
      );

  @override
  List<Object?> get props => [word, favorited, response];
}
