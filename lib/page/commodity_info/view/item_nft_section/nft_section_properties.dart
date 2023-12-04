import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qpp_example/model/nft/nft_trait.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class NFTSectionProperties<List> extends NFTSection {
  const NFTSectionProperties({super.key, required super.data});

  @override
  State<StatefulWidget> createState() => StateProperties();
}

class StateProperties extends StateSection {
  @override
  Widget get sectionContent => PropertiesContent(properties: widget.data);

  @override
  String get sectionTitle => 'Properties';

  @override
  String get sectionTitleIconPath =>
      'assets/desktop-icon-commodity-nft-properties.svg';
}

class PropertiesContent extends StatelessWidget {
  final List<NFTTrait> properties;
  const PropertiesContent({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return ItemProperty(
      property: properties[0],
    );
    // return const SizedBox.shrink();
  }
}

/// property 元件
class ItemProperty extends StatelessWidget {
  final NFTTrait property;
  const ItemProperty({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      constraints: const BoxConstraints(maxWidth: 223, maxHeight: 88),
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: QppColors.stPatricksBlue,
        border: Border.all(
          color: QppColors.darkPastelBlue,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            property.traitType,
            style: QppTextStyles.web_16pt_body_platinum_L,
          ),
          Text(
            property.value,
            style: QppTextStyles.web_16pt_body_platinum_L,
          )
        ],
      ),
    );
  }
}
