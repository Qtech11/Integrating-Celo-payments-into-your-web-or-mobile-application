import 'package:celo_flutter_payment/product_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  // Sample list of products
  final List<Product> _products = [
    Product(
      name: 'Sneakers',
      price: 0.001,
      imageUrl:
          'https://www-konga-com-res.cloudinary.com/w_auto,f_auto,fl_lossy,dpr_auto,q_auto/media/catalog/product/I/E/203218_1662079565.jpg',
    ),
    Product(
      name: 'Shirt',
      price: 12,
      imageUrl:
          'https://static.fibre2fashion.com/MemberResources/LeadResources/1/2021/5/Seller/21194119/Images/21194119_0_men-s-shirts.jpg',
    ),
    Product(
      name: 'Jean trouser',
      price: 8,
      imageUrl:
          'https://zuba.com.ng/wp-content/uploads/2020/06/13197251460_1820160955.460x460xz.jpg',
    ),
    Product(
      name: 'Nike Slide',
      price: 15,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0055/5502/8083/products/IMG-5706646f5eecd68151b6d61e1df56ca9-V_1024x1024@2x.jpg?v=1618572604',
    ),
  ];

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  final String recipientAddress =
      '0x8e09955862A3Ae65bDfBAf82e55edA90E12fC813'; // replace with the receiver address

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 1.5,
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: ((context, i) {
          return Container(
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.black12,
                  spreadRadius: 0.5,
                ),
              ],
            ),
            child: Column(
              children: [
                Image.network(_products[i].imageUrl),
                Text(_products[i].name),
                ElevatedButton(
                  child: Text('Pay ${_products[i].price} Celo'),
                  onPressed: () {
                    // Replace 'celo-payment-url' with the actual Celo payment URL
                    _launchURL(
                        'celo://wallet/pay?address=$recipientAddress&amount=${_products[i].price}&comment=${_products[i].name}');
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
