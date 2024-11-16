import 'dart:async';

enum Role { Admin, Customer }

class Product {
  String productName;
  double price;
  bool inStock;

  Product(this.productName, this.price, this.inStock);
}

class User {
  String name;
  int age;
  late List<Product> produk;
  Role? role;

  User(this.name, this.age);
}

class AdminUser extends User {
  AdminUser(String name, int age) : super(name, age) {
    role = Role.Admin;
    produk = [];
  }

//Menambahkan produk ke daftar produk customer
  void tambahProduk(Product product) {
    try {
      if (!product.inStock) {
        throw Exception(
            "Produk ${product.productName} tidak tersedia dalam stok");
      }
      produk.add(product); //ditambahkan ke daftar produk pengguna
      print("Produk ${product.productName} berhasil ditambahkan");
    } on Exception catch (e) {
      print("Gagal menambahkan produk: $e");
    }
  }

//Menghapus produk dari daftar produk customer
  void hapusProduk(Product product) {
    produk.remove(product);
    print("Produk ${product.productName} telah dihapus");
  }
}

class CustomerUser extends User {
  CustomerUser(String name, int age) : super(name, age) {
    role = Role.Customer;
    produk = [];
  }

//Melihat daftar produk
  void LihatProduk() {
    if (produk.isEmpty) {
      print("Tidak ada produk untuk ditampilkan");
    } else {
      print("Daftar produk:");
      for (var product in produk) {
        print("${product.productName} - Rp${product.price}");
      }
    }
  }
}

Future<Product> fetchProductDetails(String productName) async {
  print("Mengambil detail produk $productName...");
  await Future.delayed(Duration(seconds: 3));
  return Product(productName, 40000, true);
}

void main() async {
  Map<String, Product> katalog = {
    'Sabun': Product('Sabun', 21000, true),
    'Sampo': Product('Sampo', 31000, true),
    'Sikat gigi': Product('Sikat gigi', 19000, false)
  };

  Set<Product> produkSet = {};

//objek admin dan customer
  AdminUser admin = AdminUser('admin', 31);
  CustomerUser customer = CustomerUser('customer', 20);

  for (var product in katalog.values) {
    produkSet.add(product);
    admin.tambahProduk(product);
  }

  customer.produk = admin.produk;
  customer.LihatProduk();

  Product newProduct = await fetchProductDetails('Pasta gigi');
  katalog[newProduct.productName] = newProduct;

  print('Daftar produk di katalog setelah pengambilan data asinkron:');
  for (var product in katalog.values) {
    print(
        '${product.productName} - \$${product.price} - ${product.inStock ? "Tersedia" : "Tidak Tersedia"}');
  }
}
