import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shark_valley/models/patrolLog.dart';
import 'package:shark_valley/models/wildLifeSight.dart';
import 'package:shark_valley/services/logProvider.dart';
import 'package:shark_valley/vault.dart';


class WildLifePage extends ConsumerWidget {
  const WildLifePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<WildLifeSight> sights =ref.watch(patrolLogProvider).wildlifeSights;
    if(sights.isEmpty){
      for(int i=0; i<wildLifeDefaultItems.length; i++){
        WildLifeSight currentSight =WildLifeSight(name: wildLifeDefaultItems[i], amount: 0, createdBy: Vault.userName??"" );
        currentSight.localImagePath = ("${Vault.assetsImagePath}$i.jpg")??'';
        sights.add(currentSight);
      }
    }
    List<SightController> sightControllers = [];
    sightControllers = sights.map((sight) =>SightController( sight:sight,  controller:TextEditingController(text:sight.amount.toString()))).toList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            context.go('/suppliesExpendedPage');
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        title: const Text('Wild Life'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions:  [
          const Icon(Icons.receipt_long),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.more_vert),
          )
        ],

      ),
      resizeToAvoidBottomInset: false,
      body: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: const ListTile(
            leading: Text(''),
            title: Text('Name'),
            trailing:  Text('No', style: TextStyle(fontSize: 14),),

          ),
        ),

        SizedBox(
            height: 500, // Constrain height.

            child: Scrollbar(
              child: ListView.separated(
                itemCount: sightControllers.length,
                itemBuilder: (BuildContext context, int index) {
                  return  ListTile(
                    onTap: () {
                    },

                    // This sets text color and icon color to red when list tile is disabled and
                    // green when list tile is selected, otherwise sets it to black.

                    leading:Image(image: ResizeImage(AssetImage(sightControllers[index].sight.localImagePath??''), width: 200, height: 150)),
                    title:  Text(sightControllers[index].sight.name),
                    trailing:        SizedBox(
                  width: 40, height: 40, child: TextFormField(

                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.top,
                        controller: sightControllers[index].controller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide( width: .5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide( width: .5),
                          ),
                        )

                    ),
                  ));
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 1),
              ),
            )),
        const SizedBox(
          height: 50, // <-- SEE HERE
        ),
        FilledButton(
            onPressed: () {
for(int i=0; i < sightControllers.length; i++){
  ref.read(patrolLogProvider.notifier).addOrUpdateWildLifeSight(WildLifeSight(name: sightControllers[i].sight.name, amount: int.parse(sightControllers[i].controller.text), localImagePath:sights[i].localImagePath, createdBy: Vault.userName??"-"));
}

              context.go('/notesPage');
            },
            child: const Text('Next'))
      ]),

    );
  }
}


class SightController {
  WildLifeSight sight;
  TextEditingController controller;
  SightController({required this.sight, required this.controller});
}