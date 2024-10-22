

import '../repositories/spooncular.dart';

void main() async {
  var mealPlan = await SpoonacularService.instance.generateMealPlan(
      targetCalories: 2000,
      diet: 'vegetarian',
      timeFrame: 'day',
      exclude: 'nuts'
  );
  print(mealPlan);
}
