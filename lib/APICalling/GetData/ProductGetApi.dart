import 'package:flutter/material.dart';

import 'ServicesClass.dart';

class ProductApi extends StatefulWidget {
  const ProductApi({super.key});

  @override
  State<ProductApi> createState() => _ProductApiState();
}

class _ProductApiState extends State<ProductApi> {
  ProductServices pdservice = ProductServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Api'),
        // actions: [
        //   IconButton(
        //       onPressed: getData(), icon: Icon(Icons.refresh_outlined))
        // ],
      ),
      body: Center(
        child: FutureBuilder(
          future: ProductServices.getData(),
          builder: (context, snapShot) {
            print('Main Screen');
            if (snapShot.hasData) {
              List dataList = snapShot.data! as List;
              return ListView.separated(
                itemCount: dataList.length,
                separatorBuilder: (context, index) => Divider(thickness: 3),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.transparent,child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage('${dataList[index].image.toString()}'))),),
                    ),
                    title: Text('${dataList[index].title}'),
                    subtitle: Text('${dataList[index].description.toString()}'),
                  );
                },
              );
            } else {
              return CircularProgressIndicator(color: Colors.red);
            }
          },
        ),
      ),
    );
  }
}
