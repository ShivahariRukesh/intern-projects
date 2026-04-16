List<T> handleShuffleList<T>(List<T> originalList) {
  return List.from(originalList)..shuffle();
}
