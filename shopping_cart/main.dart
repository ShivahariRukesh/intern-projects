import 'dart:io';

typedef ItemType = List<Map<String, Object>>;
void main() {
  ItemType items = [];

  //User Module
  customDisplay('Are you an admin or a customer');
  print(
    "Press \'a\'  if you are admin OR  '\c\' if you are a customer  OR \'enter\' to exit",
  );

  String user = stdin.readLineSync()!;

  while (user != '') {
    if (user case 'a') {
      //Admin Module
      adminModule(items, user);
      customDisplay('Are you an admin or a customer');
      print(
        "Press \'a\'  if you are admin OR  '\c\' if you are a customer  OR \'enter\'",
      );
      user = stdin.readLineSync()!;
    } else if (user case 'c') {
      // Customer Module
      customerModule(items, user);
      customDisplay('Are you an admin or a customer');
      print(
        "Press \'a\'  if you are admin OR  '\c\' if you are a customer  OR \'enter\'",
      );
      user = stdin.readLineSync()!;
    }
  }

  customDisplay("See you later!!!!");
}

void customerModule(ItemType items, String user) {
  ItemType cartItems = [];
  print(
    "Welcome to the store!!!\n Choose the option to your liking:\n",
  );

  showMenu(user);

  String? customerOption = stdin.readLineSync();

  while (customerOption != 'q') {
    switch (customerOption) {
      case 'a':
        addItemsToCart(items, cartItems);
      case 'l':
        getAllItems(items);
      case 'g':
        getAllCartItems(cartItems);
      case 'b':
        buyItems(cartItems);
      case 'd':
        removeItemFromCart(items, cartItems);
      case 'q':
        break;
      default:
        {
          print(
            '\n\n\nInvalid option pressed. Please enter the valid option from below :)'
                .padLeft(8),
          );
          showMenu(user);
        }
    }
    customerOption = stdin.readLineSync();
  }
}

void adminModule(ItemType items, String user) {
  customDisplay(
    "Welcome Admin!!",
    8,
    " What would you like to do ?",
  );

  showMenu(user);

  String? adminOption = stdin.readLineSync();

  while (adminOption != 'q') {
    switch (adminOption) {
      case 'i':
        addItem(items);
      case 'u':
        updateItem(items);
      case 'd':
        deleteItems(items);
      case 'r':
        getAllItems(items);
      case 'q':
        break;
      default:
        {
          customDisplay(
            'Invalid option pressed. Please enter the valid option from below :)',
            8,
          );
          showMenu(user);
        }
    }
    adminOption = stdin.readLineSync();
  }
}

//Accessibility: Admin Operations
void addItem(ItemType items) {
  //Input : Taking input to add an item
  //Exception : Need to handle exception when inputting the item's details
  customDisplay("Please enter the item name", 8);
  String itemName = stdin.readLineSync() ?? 'item';

  customDisplay("Please enter the item quantity", 8);
  int itemQuantity = int.parse(stdin.readLineSync() ?? '0');

  customDisplay("Please enter the price", 8);
  double itemPrice = double.parse(
    stdin.readLineSync() ?? '0.0',
  );

  //Adding the inputted item into the items list
  items.add({
    'name': itemName,
    'price': itemPrice,
    'quantity': itemQuantity,
  });

  //CTA : Ending add items operation
  customDisplay(
    "Your item has been added successfully",
    8,
    "Press the options for your next desired operation",
  );
}

void deleteItems(ItemType items) {
  //Input : Taking input to remove an item
  //Exception : Need to handle exception when taking the input to delete an item

  //Input the item name that needs to be deleted
  customDisplay(
    "Please enter the name of an item that you want to delete",
    8,
  );
  String? removeItemName = stdin.readLineSync();

  items.removeWhere(
    (item) => item['name'] == removeItemName,
  );

  //CTA : Ending delete operation
  customDisplay(
    "Your item has been deleted successfully",
    8,
    " Press the options for your next desired operation",
  );
}

void updateItem(ItemType items) {
  // Input: Taking input for updating the item
  // Exception : Need to handle exception when taking the input to update the item

  //Input the item name that needs to be updated
  customDisplay(
    "Please enter the item you want to update",
    8,
  );
  String updateName = stdin.readLineSync()!;

  //Input value to update item quantity
  customDisplay(
    "Please enter the new value for the quantity",
    8,
  );
  int updateQuantity = int.parse(
    stdin.readLineSync() ?? '0',
  );

  //Input value to update item price
  customDisplay(
    "Please enter the new value for the price",
    8,
  );
  int updatePrice = int.parse(
    stdin.readLineSync() ?? '0.0',
  );

  int index = 0;
  Map<String, Object> updateItem = Map();
  for (Map<String, Object> item in items) {
    if (item["name"] == updateName) {
      updateItem = {
        ...item,
        "quantity": updateQuantity,
        "price": updatePrice,
      };

      break;
    }
    index++;
  }
  items[index] = updateItem;

  //CTA : Ending update operation
  customDisplay(
    "Your item has been updated successfully",
    8,
    " Press the options for your next desired operation",
  );
}

//Accessibility: User Operation
void getAllItems(ItemType items) {
  print(items);

  //CTA : Ending getting all items operation
  print(
    "\n\n\nPress the options for your next desired operation"
        .padLeft(8),
  );
}

//Accessibility : Customer Operation
void addItemsToCart(ItemType items, ItemType cartItems) {
  // Input: Taking input for buying an item
  // Exception : Need to handle exception when taking the input to buy an item
  customDisplay(
    "Please enter the item name you want to buy",
    8,
  );
  String? itemNameToBuy = stdin.readLineSync();

  int itemToBuyIndex = items.indexWhere(
    (item) => item["name"] == itemNameToBuy,
  );

  Map<String, Object> itemToBuy = items[itemToBuyIndex];

  //Flagging duplicate items in the cart and manipulating quantity based on that
  bool isDuplicateItemFound = false;
  for (int i = 0; i < cartItems.length; i++) {
    if (cartItems[i]["name"] == itemToBuy["name"]) {
      cartItems[i] = {
        ...cartItems[i],
        "quantity": (cartItems[i]["quantity"] as int) + 1,
      };
      isDuplicateItemFound = true;
      break;
    }
  }

  if (!isDuplicateItemFound) {
    cartItems.add({...itemToBuy, "quantity": 1});
  }

  //Optimize : if possible use another shortcut conditional expression
  //If quantity is already 1 and as it is bought one time its better to remove this item from the list as it won't be available in the stock
  //Else decrease the quantity by 1
  if (items[itemToBuyIndex]["quantity"] == 1) {
    items.removeAt(itemToBuyIndex);
  } else {
    items[itemToBuyIndex] = {
      ...itemToBuy,
      "quantity": (itemToBuy["quantity"] as int) - 1,
    };
  }

  //CTA : Ending the buy operation
  customDisplay(
    "You have added an item to the cart.",
    8,
    " Press the options for your next desired operation",
  );
}

void buyItems(ItemType cartItems) {
  print(
    "\n\n\n-------------- Transaction is ongoing--------------\n -------------- Please wait for a while!!!--------------",
  );
  double totalAmount = 0;

  print("\n\n\n*****\tHere's your receipt\t*****\n\n");
  print(
    "==================================================",
  );
  print("                 Shopping Cart Mall");
  print(
    "--------------------------------------------------",
  );
  print(
    "Date      :     ${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
  );
  print(
    "--------------------------------------------------",
  );
  print(
    "| Item Name        | Quantity | Unit Price |   Total   |",
  );
  print(
    "--------------------------------------------------",
  );

  cartItems.forEach((cartItem) {
    double itemTotalPrice =
        (cartItem["price"] as double) *
        (cartItem["quantity"] as int);

    totalAmount = totalAmount + itemTotalPrice;
    print(
      "| ${cartItem["name"].toString().padRight(16)} "
      "| ${cartItem["quantity"].toString().padLeft(3)} "
      "| ${(cartItem["price"] as double).toStringAsFixed(2).padLeft(10)} "
      "| ${(itemTotalPrice).toStringAsFixed(2).padLeft(8)} |",
    );
  });

  print(
    "--------------------------------------------------",
  );
  print(
    "Total Amount : ${totalAmount.toStringAsFixed(2).padLeft(10)}",
  );
  print(
    "Discount(5%) : ${(totalAmount * 0.05).toStringAsFixed(2).padLeft(10)}",
  );
  print(
    "Net Amount   : ${(totalAmount - totalAmount * 0.05).toStringAsFixed(2).padLeft(10)}",
  );
  print(
    "==================================================",
  );
  print("              Thank You For Shopping!");
  print(
    "==================================================",
  );

  //CTA : Ending getting all cart items operation
  print(
    "\n\n\n-------------- Transaction successful --------------\n\n\n -------------- Press the options for your next desired operation --------------",
  );
}

void removeItemFromCart(
  ItemType items,
  ItemType cartItems,
) {
  //Input : Taking input to remove an item from the cart
  //Exception : Need to handle exception when taking the input to remove an item from the cart

  //Input the item name that needs to be removed from the cart
  customDisplay(
    "Please enter the name of an item that you want to remove from the cart",
    8,
  );
  String? removeCartItemName = stdin.readLineSync();

  int itemToRemoveFromCartIndex = cartItems.indexWhere(
    (item) => item["name"] == removeCartItemName,
  );
  print('the item is $itemToRemoveFromCartIndex');

  Map<String, Object> itemToRemoveFromCart =
      cartItems[itemToRemoveFromCartIndex];
  print('the item is $itemToRemoveFromCart');
  //Flagging duplicate items in the item and manipulating quantity based on that
  bool isDuplicateItemFound = false;
  for (int i = 0; i < items.length; i++) {
    if (items[i]["name"] == itemToRemoveFromCart["name"]) {
      items[i] = {
        ...items[i],
        "quantity": (items[i]["quantity"] as int) + 1,
      };
      isDuplicateItemFound = true;
      break;
    }
  }

  if (!isDuplicateItemFound) {
    items.add({...itemToRemoveFromCart, "quantity": 1});
  }

  print(
    "current cart items ${cartItems[itemToRemoveFromCartIndex]["quantity"]}",
  );

  //Optimize : if possible use another shortcut conditional expression
  //If quantity is already 1 and as it is bought one time its better to remove this item from the list as it won't be available in the stock
  //Else decrease the quantity by 1
  if (cartItems[itemToRemoveFromCartIndex]["quantity"] ==
      1) {
    cartItems.removeAt(itemToRemoveFromCartIndex);
  } else {
    cartItems[itemToRemoveFromCartIndex] = {
      ...itemToRemoveFromCart,
      "quantity":
          (itemToRemoveFromCart["quantity"] as int) - 1,
    };
  }

  //CTA : Ending removing operation
  customDisplay(
    "You have removed an item from your cart",
    8,
    "Press the options for your next desired operation",
  );
}

// void generateReceipt(
//   ItemType cartItems,
//   double totalPrice,
// ) {}
void getAllCartItems(cartItems) {
  print(cartItems);

  //CTA : Ending getting all cart items operation
  customDisplay(
    "Press the options for your next desired operation",
    8,
  );
}

//Show the menu of valid options to carryout the corresponding operation
void showMenu(String user) {
  if (user == 'c') {
    print("\n\n\n1. Add an item to cart, Press \'a'\' ");
    print("2. List all items , Press \'l'\' ");
    print("3. List all your cart items , Press \'g\' ");
    print("4. Buy the items in your cart, Press\'b\'");
    print("5. Remove the items from your cart, Press\'d\'");
    print("6. Exit, Press \'q\'");
  } else {
    print("\n\n\n1. Add an item , Press \'i'\' ");
    print("2. Update an item , Press \'u'\' ");
    print("3. Remove an item , Press \'d'\' ");
    print("4. Read all items , Press \'r'\' ");
    print("5. Exit, Press \'q\'");
  }
}

void customDisplay(
  String content1, [
  int padding = 0,
  String content2 = '',
]) {
  print(
    "\n\n\n$content1 ${switch (content2 != '') {
          true => '\n\n\n',
          _ => '',
        }} $content2"
        .padLeft(padding),
  );
}
