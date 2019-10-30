import 'package:flutter/material.dart';

class Product {
  final String title;
  final String desc;

  Product(this.title, this.desc);
}

void main(){
  runApp(MaterialApp(
    title: "带数据导航",
    home: ProductList(
      products:List.generate(20, (i)=>Product('商品 $i','这个一个商品详情，编号为$i')))
    ),
  );
}

class ProductList extends StatelessWidget{

  final List<Product> products;

  ProductList({Key key,@required this.products}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("商品详情"),),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context,index){
          return ListTile(
            title: Text(products[index].title),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(
                builder: (context)=>ProductDetail(product:products[index])
              ));
            },
          );
        },
      ),
    );
  }
}

class ProductDetail extends StatelessWidget{

  final Product product;

  ProductDetail({Key key,@required this.product}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${product.title}'),),
      body: Center(
        child: Text(
          "${product.desc}"
        ),
      ),
    );

  }
}

