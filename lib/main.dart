import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(IceCreamApp());
}

class IceCreamApp extends StatefulWidget {
  @override
  _IceCreamAppState createState() => _IceCreamAppState();
}

class _IceCreamAppState extends State<IceCreamApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ice Cream Shop',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: _themeMode,
      home: IceCreamHomePage(
        onThemeChange: (ThemeMode mode) {
          setState(() {
            _themeMode = mode;
          });
        },
      ),
    );
  }
}

class IceCreamHomePage extends StatefulWidget {
  final Function(ThemeMode) onThemeChange;

  IceCreamHomePage({required this.onThemeChange});

  @override
  _IceCreamHomePageState createState() => _IceCreamHomePageState();
}

class _IceCreamHomePageState extends State<IceCreamHomePage> {
  List<Map<String, String>> iceCreamMenu = [
    {
      'name': 'Vanilla Dream',
      'image':
          'https://th.bing.com/th/id/OIP.CyTN3WxKptQSSFfKd6Qs3gHaF-?w=203&h=164&c=7&r=0&o=5&pid=1.7',
      'price': '₹80',
      'description':
          'Pure, rich vanilla made with real Madagascar vanilla beans.',
      'details':
          'Vanilla Dream is made with premium vanilla beans and has a creamy texture that melts in your mouth. Perfect for those who love classic flavors with a touch of elegance.',
    },
    {
      'name': 'Chocolate Delight',
      'image':
          'https://th.bing.com/th/id/OIP.3Uoroez-JGH1L0Wb6NN2owHaHa?w=203&h=202&c=7&r=0&o=5&pid=1.7',
      'price': '₹100',
      'description':
          'Decadent chocolate with swirls of fudge and chocolate chunks.',
      'details':
          'Chocolate Delight is a rich, indulgent treat featuring chocolate chunks and swirls of smooth fudge. It’s a dream come true for chocolate lovers.',
    },
    {
      'name': 'Strawberry Bliss',
      'image':
          'https://th.bing.com/th/id/OIP.AqtlucZTMt8UhaGQLGUujgAAAA?rs=1&pid=ImgDetMain',
      'price': '₹120',
      'description': 'Refreshing strawberry made with handpicked berries.',
      'details':
          'Strawberry Bliss uses only the freshest strawberries to create a light, fruity flavor. Enjoy a burst of summer with every bite.',
    },
    {
      'name': 'Mint Chocolate Chip',
      'image':
          'https://th.bing.com/th/id/OIP.tix6J5w_C__1OueDoqhrYwHaLG?w=203&h=304&c=7&r=0&o=5&pid=1.7',
      'price': '₹130',
      'description': 'Cool mint ice cream with chocolate chunks.',
      'details':
          'Mint Chocolate Chip is a refreshing ice cream with a minty flavor and loaded with crunchy chocolate chips. Perfect for a cool treat.',
    },
    {
      'name': 'Cookie Dough Craze',
      'image':
          'https://th.bing.com/th/id/OIP.pNXdHSJSEivhn3h01UaTXAAAAA?w=203&h=304&c=7&r=0&o=5&pid=1.7',
      'price': '₹180',
      'description':
          'Vanilla ice cream with chunks of cookie dough and chocolate chips.',
      'details':
          'Cookie Dough Craze is a creamy vanilla ice cream filled with chunks of cookie dough and chocolate chips, offering a delightful texture and taste.',
    },
    {
      'name': 'Caramel Swirl',
      'image':
          'https://th.bing.com/th/id/OIP.6SzzxEcLo6rpUi9X-EFrmgHaLH?w=203&h=304&c=7&r=0&o=5&pid=1.7',
      'price': '₹200',
      'description': 'Rich caramel ice cream with swirls of caramel sauce.',
      'details':
          'Caramel Swirl offers a smooth, buttery caramel ice cream with rich caramel swirls throughout. A sweet treat for caramel lovers.',
    },
    {
      'name': 'Pistachio Perfection',
      'image':
          'https://th.bing.com/th/id/OIP.rZSOh-HL93pphJHluUIydgHaLH?w=203&h=304&c=7&r=0&o=5&pid=1.7',
      'price': '₹170',
      'description': 'Creamy pistachio ice cream made with roasted pistachios.',
      'details':
          'Pistachio Perfection features a creamy, nutty flavor with finely ground roasted pistachios. Perfect for a rich, nutty indulgence.',
    },
    {
      'name': 'Mango Tango',
      'image':
          'https://th.bing.com/th/id/OIP.ym33m-LoRlZ4LGPNWO4cXwHaLG?w=203&h=304&c=7&r=0&o=5&pid=1.7',
      'price': '₹180',
      'description': 'Tropical mango ice cream made with real mangoes.',
      'details':
          'Mango Tango is a vibrant, fruity ice cream bursting with the tropical flavor of ripe mangoes. A refreshing choice for a hot day.',
    },
    {
      'name': 'Cookies and Cream',
      'image':
          'https://th.bing.com/th/id/OIP.CiXooBrKpkGXNBQBgyzxYwHaLH?w=203&h=304&c=7&r=0&o=5&pid=1.7',
      'price': '₹150',
      'description': 'Vanilla ice cream with chunks of chocolate cookies.',
      'details':
          'Cookies and Cream combines classic vanilla ice cream with crunchy, chocolatey cookie chunks for a deliciously fun treat.',
    },
    {
      'name': 'Butter Pecan Bliss',
      'image':
          'https://th.bing.com/th/id/OIP.NvF-_i9VzQvWV2n3hqs-AQHaE7?w=271&h=180&c=7&r=0&o=5&pid=1.7',
      'price': '₹165',
      'description': 'Buttery pecan ice cream with roasted pecans.',
      'details':
          'Butter Pecan Bliss features a creamy, buttery flavor with roasted pecans mixed throughout. A classic favorite with a rich, nutty twist.',
    },
  ];

  List<Map<String, String>> cart = [];
  List<Map<String, String>> wishlist = [];

  void addToCart(Map<String, String> iceCream) {
    setState(() {
      final existingItem = cart.firstWhere(
        (item) => item['name'] == iceCream['name'],
        orElse: () => {},
      );

      if (existingItem.isNotEmpty) {
        final index =
            cart.indexWhere((item) => item['name'] == iceCream['name']);
        cart[index]['quantity'] =
            ((int.parse(cart[index]['quantity']!) + 1).toString());
      } else {
        cart.add({
          'name': iceCream['name']!,
          'image': iceCream['image']!,
          'price': iceCream['price']!,
          'quantity': '1'
        });
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${iceCream['name']} added to cart!"),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }

  void removeFromCart(Map<String, String> iceCream) {
    setState(() {
      final existingItem = cart.firstWhere(
        (item) => item['name'] == iceCream['name'],
        orElse: () => {},
      );

      if (existingItem.isNotEmpty) {
        final index =
            cart.indexWhere((item) => item['name'] == iceCream['name']);
        if (int.parse(cart[index]['quantity']!) > 1) {
          cart[index]['quantity'] =
              ((int.parse(cart[index]['quantity']!) - 1).toString());
        } else {
          cart.removeAt(index);
        }
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${iceCream['name']} removed from cart!"),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void addToWishlist(Map<String, String> iceCream) {
    setState(() {
      if (!wishlist.any((item) => item['name'] == iceCream['name'])) {
        wishlist.add(iceCream);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${iceCream['name']} added to wishlist!"),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void removeFromWishlist(Map<String, String> iceCream) {
    setState(() {
      wishlist.removeWhere((item) => item['name'] == iceCream['name']);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${iceCream['name']} removed from wishlist!"),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void updateCartQuantity(Map<String, String> iceCream, int quantity) {
    setState(() {
      final index = cart.indexWhere((item) => item['name'] == iceCream['name']);
      if (index != -1) {
        cart[index]['quantity'] = quantity.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scoops & Smiles'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    cart: cart,
                    onRemove: removeFromCart,
                    onUpdateQuantity: updateCartQuantity,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishlistPage(
                      wishlist: wishlist, onRemove: removeFromWishlist),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              widget.onThemeChange(
                Theme.of(context).brightness == Brightness.light
                    ? ThemeMode.dark
                    : ThemeMode.light,
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.pink),
              child: Text(
                'Scoops & Smiles',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add_box),
              title: Text('Add Ice Cream'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddIceCreamPage(onAdd: (iceCream) {
                            setState(() {
                              iceCreamMenu.add(iceCream);
                            });
                            Navigator.pop(context);
                          })),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: iceCreamMenu.length,
        itemBuilder: (context, index) {
          final iceCream = iceCreamMenu[index];
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    iceCream['image']!,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    iceCream['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    iceCream['price']!,
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => addToCart(iceCream),
                    child: Text('Add to Cart'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => addToWishlist(iceCream),
                    child: Text('Add to Wishlist'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final List<Map<String, String>> cart;
  final Function(Map<String, String>) onRemove;
  final Function(Map<String, String>, int) onUpdateQuantity;

  CartPage({
    required this.cart,
    required this.onRemove,
    required this.onUpdateQuantity,
  });

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void checkout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Place Order'),
          content: Text('Proceed to payment for your order.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showPaymentAnimation();
              },
              child: Text('Proceed to Pay'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentAnimation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 200,
            width: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Processing Payment...'),
                ],
              ),
            ),
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close the animation dialog
      _showWarmMessage();
    });
  }

  void _showWarmMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Success!'),
          content: Text('Thank you for your purchase. Enjoy your ice cream!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  widget.cart.clear();
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Cart cleared!"),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  double calculateTotal() {
    double total = 0.0;
    for (var item in widget.cart) {
      double price = double.parse(item['price']!.replaceAll('₹', '')) *
          int.parse(item['quantity']!);
      total += price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: widget.cart.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      final iceCream = widget.cart[index];
                      return ListTile(
                        leading: Image.network(iceCream['image']!),
                        title: Text(iceCream['name']!),
                        subtitle: Text(
                            'Price: ${iceCream['price']} | Quantity: ${iceCream['quantity']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => widget.onRemove(iceCream),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              int quantity = int.parse(iceCream['quantity']!);
                              return AlertDialog(
                                title: Text('Update Quantity'),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        if (quantity > 1) {
                                          setState(() {
                                            quantity--;
                                            widget.onUpdateQuantity(
                                                iceCream, quantity);
                                          });
                                        }
                                      },
                                    ),
                                    Text('$quantity'),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                          widget.onUpdateQuantity(
                                              iceCream, quantity);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total: ₹${calculateTotal().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: checkout,
                    child: Text('Checkout'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class WishlistPage extends StatelessWidget {
  final List<Map<String, String>> wishlist;
  final Function(Map<String, String>) onRemove;

  WishlistPage({
    required this.wishlist,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Wishlist'),
      ),
      body: wishlist.isEmpty
          ? Center(
              child: Text(
                'Your wishlist is empty!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final iceCream = wishlist[index];
                return ListTile(
                  leading: Image.network(iceCream['image']!),
                  title: Text(iceCream['name']!),
                  subtitle: Text('Price: ${iceCream['price']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => onRemove(iceCream),
                  ),
                );
              },
            ),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _nameController = TextEditingController(text: 'Akanksha');
  final _emailController = TextEditingController(text: 'Akanksha07@gmail.com');
  final _phoneController = TextEditingController(text: '9354769234');

  void _updateProfile() {
    // Handle the profile update logic here
    final updatedName = _nameController.text;
    final updatedEmail = _emailController.text;
    final updatedPhone = _phoneController.text;

    print('Updated Profile: $updatedName, $updatedEmail, $updatedPhone');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddIceCreamPage extends StatefulWidget {
  final Function(Map<String, String>) onAdd;

  AddIceCreamPage({required this.onAdd});

  @override
  _AddIceCreamPageState createState() => _AddIceCreamPageState();
}

class _AddIceCreamPageState extends State<AddIceCreamPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();

  void _submit() {
    final name = _nameController.text;
    final price = _priceController.text;
    final image = _imageController.text;

    if (name.isNotEmpty && price.isNotEmpty && image.isNotEmpty) {
      final iceCream = {
        'name': name,
        'price': price,
        'image': image,
      };
      widget.onAdd(iceCream);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Ice Cream'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Add Ice Cream'),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> _submit() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final message = _messageController.text;

    if (name.isNotEmpty && email.isNotEmpty && message.isNotEmpty) {
      final response = await http.post(
        Uri.parse('https://example.com/contact'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'email': email, 'message': message}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Message sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Message'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'About Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'At Scoops & Smiles, we are passionate about crafting the finest ice cream that brings joy to every customer. Our journey began with a simple mission: to create an experience that is more than just a dessert, but a celebration of flavor and quality. We carefully select the best ingredients from around the world to ensure that each scoop is rich, creamy, and bursting with taste. Our Vanilla Dream uses real Madagascar vanilla beans, providing a smooth and elegant flavor. For chocolate lovers, our Chocolate Delight is a rich indulgence with swirls of fudge and chunks of chocolate. Strawberry Bliss captures the essence of summer with the freshest strawberries, while Mint Chocolate Chip offers a refreshing coolness paired with crunchy chocolate pieces. Cookie Dough Craze blends creamy vanilla with chunks of cookie dough and chocolate chips for a playful treat, and Caramel Swirl enchants with its smooth, buttery caramel. Pistachio Perfection delivers a nutty richness with finely ground roasted pistachios, and Mango Tango transports you to the tropics with its vibrant, fruity flavor. Cookies and Cream combines the classic taste of vanilla with chocolate cookie pieces, and Butter Pecan Bliss adds a nutty twist with roasted pecans. At Scoops and Smiles, every batch is made with care, from the precise temperature control to the exact timing of ingredient mixing. Our commitment to quality extends beyond our ice cream, as we strive to create an inviting atmosphere where every visit feels special. We believe in the power of ice cream to bring people together, and we are dedicated to making every moment at Scoops and Smiles a delightful experience.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
