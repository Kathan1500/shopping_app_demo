import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trend Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final String imagePath;
  final List<String> sizes;
  final Color backgroundColor;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imagePath,
    required this.sizes,
    required this.backgroundColor,
  });
}

class CartItem {
  final Product product;
  final String size;
  int quantity;

  CartItem({required this.product, required this.size, this.quantity = 1});
}

// final List<Product> products = [
//   Product(
//     id: 1,
//     name: 'Apple',
//     category: 'Fruit',
//     price: 1.5,
//     imagePath: 'assets/apple.png',
//     sizes: ['500g', '1kg'],
//     backgroundColor: Colors.red.shade100,
//   ),
//   Product(
//     id: 2,
//     name: 'Banana',
//     category: 'Fruit',
//     price: 0.9,
//     imagePath: 'assets/banana.png',
//     sizes: ['6 pcs', '12 pcs'],
//     backgroundColor: Colors.yellow.shade100,
//   ),
//   Product(
//     id: 3,
//     name: 'Milk',
//     category: 'Dairy',
//     price: 2.0,
//     imagePath: 'assets/milk.png',
//     sizes: ['500ml', '1L'],
//     backgroundColor: Colors.blue.shade100,
//   ),
// ];
final List<Product> products = [
  Product(
    id: 1,
    name: 'Floral Summer Dress',
    category: 'Women\'s Fashion',
    price: 29.99,
    imagePath: 'assets/dress.png',
    sizes: ['S', 'M', 'L', 'XL'],
    backgroundColor: Colors.pink.shade100,
  ),
  Product(
    id: 2,
    name: 'Casual Denim Jacket',
    category: 'Outerwear',
    price: 39.99,
    imagePath: 'assets/jacket.png',
    sizes: ['M', 'L', 'XL'],
    backgroundColor: Colors.blue.shade100,
  ),
  Product(
    id: 3,
    name: 'White Sneakers',
    category: 'Footwear',
    price: 49.99,
    imagePath: 'assets/sneakers.png',
    sizes: ['38', '40', '42', '44'],
    backgroundColor: Colors.grey.shade200,
  ),
  Product(
    id: 4,
    name: 'Beige Handbag',
    category: 'Accessories',
    price: 25.50,
    imagePath: 'assets/bag.png',
    sizes: ['One Size'],
    backgroundColor: Colors.brown.shade100,
  ),
  Product(
    id: 5,
    name: 'Black Sunglasses',
    category: 'Accessories',
    price: 15.00,
    imagePath: 'assets/sunglasses.png',
    sizes: ['One Size'],
    backgroundColor: Colors.black12,
  ),
];

List<CartItem> cartItems = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartScreen(
          cartItems: cartItems,
          onCartUpdated: () => setState(() {}),
        ),
      ),
    );
  }

  Widget buildCard(Product product) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailScreen(
            product: product,
            onAddToCart: () => setState(() {}),
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: product.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(product.category,
                        style: const TextStyle(color: Colors.black54)),
                    const SizedBox(height: 10),
                    Text('\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.asset(product.imagePath,
                  width: 100, height: 100, fit: BoxFit.cover),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4FF),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Trend Shop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: _goToCart,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: products.map(buildCard).toList(),
        ),
      ),
    );
  }
}

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductDetailScreen({super.key, required this.product, required this.onAddToCart});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = '';
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.product.sizes.first;
  }

  void _addToCart() {
    final existing = cartItems.firstWhere(
      (item) => item.product.id == widget.product.id && item.size == selectedSize,
      orElse: () => CartItem(product: widget.product, size: '', quantity: 0),
    );
    if (existing.quantity > 0) {
      existing.quantity += quantity;
    } else {
      cartItems.add(CartItem(product: widget.product, size: selectedSize, quantity: quantity));
    }
    widget.onAddToCart();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.product.backgroundColor,
      appBar: AppBar(backgroundColor: widget.product.backgroundColor, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(widget.product.imagePath, height: 200)),
            const SizedBox(height: 20),
            Text(widget.product.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            Text(widget.product.category),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: widget.product.sizes.map((s) => ChoiceChip(
                label: Text(s),
                selected: selectedSize == s,
                onSelected: (_) => setState(() => selectedSize = s),
              )).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
                    icon: const Icon(Icons.remove_circle_outline)),
                Text('$quantity', style: const TextStyle(fontSize: 18)),
                IconButton(onPressed: () => setState(() => quantity++),
                    icon: const Icon(Icons.add_circle_outline)),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _addToCart,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Add to Cart'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final VoidCallback onCartUpdated;

  const CartScreen({super.key, required this.cartItems, required this.onCartUpdated});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get total => widget.cartItems.fold(0, (s, i) => s + i.quantity * i.product.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (ctx, i) {
                      final item = widget.cartItems[i];
                      return ListTile(
                        leading: Image.asset(item.product.imagePath, width: 40),
                        title: Text('${item.product.name} (${item.size})'),
                        subtitle: Text('\$${item.product.price.toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (item.quantity > 1) {
                                    item.quantity--;
                                  } else {
                                    widget.cartItems.removeAt(i);
                                  }
                                  widget.onCartUpdated();
                                });
                              },
                            ),
                            Text('${item.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() => item.quantity++);
                                widget.onCartUpdated();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => cartItems.clear());
                      widget.onCartUpdated();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order placed successfully!')),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Checkout'),
                  ),
                )
              ],
            ),
    );
  }
}