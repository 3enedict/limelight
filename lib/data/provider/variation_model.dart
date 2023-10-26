import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class VariationModel extends ChangeNotifier {
  List<String> _variationIds = [];

  void load() {
    SharedPreferences.getInstance().then(
      (instance) {
        _variationIds = instance.getStringList("Variations") ?? [];
      },
    );
  }

  void set(int recipeId, int variationGroupId, int variationId) {
    setLocal(recipeId, variationGroupId, variationId);
    notifyListeners();
  }

  void setLocal(int recipeId, int variationGroupId, int variationId) {
    _growVariationIdsToFit(recipeId);

    bool needToAdd = true;
    _map(recipeId, (oldVariationGroupId, oldVariationId) {
      if (oldVariationGroupId == variationGroupId) {
        needToAdd = false;
        return variationId;
      }
      return oldVariationId;
    });

    if (needToAdd) _add(recipeId, variationGroupId, variationId);

    SharedPreferences.getInstance().then(
      (instance) {
        instance.setStringList("Variations", _variationIds);
      },
    );
  }

  List<(int, int)> variationIds(int recipeId) {
    if (_variationIds.length < recipeId + 1) return [];

    List<(int, int)> ids = [];
    _map(recipeId, (groupId, variationId) {
      ids.add((groupId, variationId));
      return variationId;
    });

    return ids;
  }

  List<int> missingVariations(
    int recipeId,
    int numberOfVariationGroupsInRecipe,
  ) {
    _growVariationIdsToFit(recipeId);

    List<int> ids = List.generate(numberOfVariationGroupsInRecipe, (id) => id);
    _map(recipeId, (variationGroupId, variationId) {
      ids.remove(variationGroupId);
      return variationId;
    });

    return ids;
  }

  void _add(int recipeId, int variationGroupId, int variationId) {
    String currentIds = _variationIds[recipeId];
    String additionalIds = "$variationGroupId:$variationId";
    _variationIds[recipeId] =
        currentIds == "" ? additionalIds : "$currentIds:$additionalIds";
  }

  void _growVariationIdsToFit(int recipeId) {
    while (recipeId > _variationIds.length - 1) {
      _variationIds.add("");
    }
  }

  void _map(
    int recipeId,
    int Function(int variationGroupId, int variationId) function,
  ) {
    if (_variationIds[recipeId] != "") {
      List<int> ids = _variationIds[recipeId]
          .split(":")
          .map(
            (e) => int.parse(e),
          )
          .toList();

      for (var i = 0; i < ids.length / 2; i++) {
        final variationGroupId = ids[i * 2];
        final variationId = ids[i * 2 + 1];

        ids[i * 2 + 1] = function(variationGroupId, variationId);
      }

      _variationIds[recipeId] = ids.join(":");
    }
  }
}
