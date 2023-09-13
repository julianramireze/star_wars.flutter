import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:star_wars/widgets/custom_boxhsadow.dart';

enum ShipType { starship, vehicle }

class Ship extends HookWidget {
  final String name;
  final int capacity;
  final int speed;
  final int cost;
  final ShipType type;

  Ship({
    required this.name,
    required this.capacity,
    required this.speed,
    required this.cost,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            CustomBoxShadow(
              width: 60,
              height: 60,
              colorShadow: Colors.transparent,
              colorBackground: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(5),
              child: Center(
                child: Icon(
                  type == ShipType.starship
                      ? Icons.rocket_rounded
                      : Icons.directions_car_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 35,
                ),
              ),
            )
          ],
        ),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Icon(
                        Icons.account_box_rounded,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 1),
                        child: Text(capacity.toString(),
                            maxLines: 1,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                      )
                    ]),
                    Row(children: [
                      Icon(
                        Icons.speed_rounded,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 1),
                        child: Text("${speed.toStringAsFixed(0)} km/h",
                            maxLines: 1,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                      )
                    ]),
                    Row(children: [
                      Icon(
                        Icons.monetization_on_rounded,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 1),
                        child: Text(cost.toString(),
                            maxLines: 1,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                      )
                    ]),
                  ],
                ),
              )
            ],
          ),
        ))
      ],
    );
  }
}
