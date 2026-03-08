List<num> sortByPrice(List<num> items) {
  num temp;
  for (int i = 0; i < items.length - 1; i++) {
    for (int j = 0; j < items.length - i - 1; j++) {
      if (items[j] > items[j + 1]) {
        temp = items[j];
        items[j] = items[j + 1];
        items[j + 1] = temp;
      }
    }
  }

  return items;
}
