import 'package:flutter/material.dart';
import 'package:qpp_example/page/qpp_home/model/qpp_home_page_model.dart';

/// 首頁 - 特色
class HomePageFeature extends StatelessWidget {
  const HomePageFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100, bottom: 100),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('area1-bg-xl.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          ConstrainedBox(constraints: const BoxConstraints(minWidth: 20)),
          Expanded(child: left()),
          const SizedBox(height: 24, width: 24),
          Expanded(child: _FeatureInfo()),
          ConstrainedBox(constraints: const BoxConstraints(minWidth: 20))
        ],
      ),
    );
  }

  /// 左邊
  Widget left() {
    return Column(
      children: [
        const Text(
          '數位背包輕鬆創建物品，管理介面簡單',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Image.asset('area1-KV.png')
      ],
    );
  }
}

/// 特色資訊
class _FeatureInfo extends StatefulWidget {
  @override
  State<_FeatureInfo> createState() => _FeatureInfoState();
}

class _FeatureInfoState extends State<_FeatureInfo> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
            children:
                FeatureInfoType.values.map((e) => featureInfoItem(e)).toList());
      },
    );
  }

  // 特色資訊Item
  StatefulWidget featureInfoItem(FeatureInfoType type) {
    bool isHover = false;

    return StatefulBuilder(
      builder: (context, setState) {
        updateHover(bool value) {
          setState(() {
            isHover = value;
          });
        }

        return MouseRegion(
          onEnter: (event) => updateHover(true),
          onExit: (event) => updateHover(false),
          child: Padding(
            padding:
                EdgeInsets.only(bottom: type == FeatureInfoType.more ? 0 : 20),
            child: Row(
              children: [
                Image.asset(type.image, width: 50, scale: 1),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(type.title,
                        style: TextStyle(
                            color: isHover ? Colors.blue : Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(type.directions,
                        style: TextStyle(
                            color: isHover ? Colors.black : Colors.grey,
                            fontSize: 16)),
                  ],
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
