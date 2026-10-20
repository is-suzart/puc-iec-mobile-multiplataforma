// lib/state/favorites.dart
//
// Ex2 (TASK 2): estado compartilhado de favoritos com Riverpod.
//
// O provider é a ÚNICA fonte de verdade do app: o MovieCard, o contador do
// header e o botão "limpar" leem/escrevem exatamente este mesmo estado —
// nada é passado por parâmetro (prop drilling).

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier que guarda os ids favoritados como um `Set<int>`.
///
/// O estado é imutável: cada `toggle`/`clear` cria um **novo** Set, o que faz
/// o Riverpod avisar todos os `ref.watch(favoritesProvider)` e redesenhar só
/// quem depende dele.
class FavoritesNotifier extends Notifier<Set<int>> {
  @override
  Set<int> build() => <int>{};

  /// Adiciona o id aos favoritos se ainda não estiver lá; remove se estiver.
  void toggle(int id) {
    state = state.contains(id) ? ({...state}..remove(id)) : {...state, id};
  }

  /// Esvazia todos os favoritos (usado pelo botão "limpar" — TASK 5).
  void clear() => state = <int>{};
}

final favoritesProvider =
    NotifierProvider<FavoritesNotifier, Set<int>>(FavoritesNotifier.new);
