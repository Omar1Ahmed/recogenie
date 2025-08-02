class SupabaseNamesHelper{
  static final schema = Schema();
  static final tables = Tables();
}

class Schema{

   final public = 'public';
}

class Tables{

   final menuItemsTable = MenuItems();
   final cart = Cart();

}

class MenuItems{
   final tableName = 'menu_items';
   final id = 'id';
   final name = 'name';
   final price = 'price';
   final image = 'image';

}

class Cart{
   final tableName = 'cart';
   final id = 'id';
   final menuItemId = 'item_id';
   final quantity = 'quantity';
   final userId = 'user_id';
}
