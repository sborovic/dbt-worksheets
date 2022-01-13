import "package:flutter/material.dart";
import "package:app/db.dart";

class SkillsList extends StatefulWidget {
  final List<SkillsNode> skillNodes;
  const SkillsList({required this.skillNodes, Key? key}) : super(key: key);

  @override
  _SkillsListState createState() => _SkillsListState();
}

class _SkillsListState extends State<SkillsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          primary: false,
          shrinkWrap: true,
          children: widget.skillNodes.map((e) {
            if (e.isLeaf == true) {
              return Container(
                // margin: EdgeInsets.all(8),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10.0),
                //   color: Colors.white,
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.black,
                //       blurRadius: 2.0,
                //       spreadRadius: 0.0,
                //       offset:
                //           Offset(2.0, 2.0), // shadow direction: bottom right
                //     )
                //   ],
                // ),
                child: Container(
         
                  margin: EdgeInsets.all(2),
                  //margin: EdgeInsets.symmetric(vertical: 5, horizontal:5),
                  child: Row(
                    children: [
                    Container(
                      margin: const EdgeInsets.only(left:25),
                      child: Text('01', style: TextStyle(color: Theme.of(context).primaryColor),)),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25),
                          child: Text(
                            e.title,
                            //   overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(25),
                        child: Icon(Icons.check),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                // margin: EdgeInsets.all(8),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(8.0),
                //   color: Colors.white,
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.black,
                //       blurRadius: 2.0,
                //       spreadRadius: 0.0,
                //       offset:
                //           Offset(2.0, 2.0), // shadow direction: bottom right
                //     )
                //   ],
                // ),
                child: Column(children: [
                  ExpansionTile(title: Text(e.title),

                      //  subtitle: const Text('Trailing expansion arrow icon'),
                      children: <Widget>[
                        SkillsList(skillNodes: getChildrenOf(e.id)),
                      ])
                ]),
              );
            }
          }).toList()),
    );
  }
}
