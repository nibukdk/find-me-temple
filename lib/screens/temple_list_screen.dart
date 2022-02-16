import 'package:church/drawer/drawer.dart';
import 'package:church/provider/temple_state_provider.dart';
import 'package:church/widgets/temple_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TempleListScreen extends StatelessWidget {
  const TempleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final templeList = Provider.of<TempleProvider>(context).getTemples;
    return Scaffold(
      appBar: AppBar(title: const Text("Temples Near You")),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "List of Temples Near You.",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemBuilder: (context, i) => TempleItemWidget(
                    title: templeList[i].name,
                    address: templeList[i].address,
                    imageUrl: templeList[i].imgUrl,
                    establishedDate: templeList[i].establishedDate.toString(),
                  ),
                  itemCount: templeList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
