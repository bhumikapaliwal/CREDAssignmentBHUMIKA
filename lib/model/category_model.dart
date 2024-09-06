class ExploreCred {
  final List<Section> sections;

  ExploreCred({required this.sections});

  factory ExploreCred.fromJson(Map<String, dynamic> json) {
    return ExploreCred(
      sections: (json['sections'] as List)
          .map((section) => Section.fromJson(section))
          .toList(),
    );
  }
}

class Section {
  final TemplateProperties templateProperties;

  Section({required this.templateProperties});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      templateProperties: TemplateProperties.fromJson(json['template_properties']),
    );
  }
}

class TemplateProperties {
  final Header header;
  final List<Item> items;

  TemplateProperties({required this.header, required this.items});

  factory TemplateProperties.fromJson(Map<String, dynamic> json) {
    return TemplateProperties(
      header: Header.fromJson(json['header']),
      items: (json['items'] as List)
          .map((item) => Item.fromJson(item))
          .toList(),
    );
  }
}

class Header {
  final String title;

  Header({required this.title});

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(
      title: json['title'],
    );
  }
}

class Item {
  final DisplayData displayData;

  Item({required this.displayData});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      displayData: DisplayData.fromJson(json['display_data']),
    );
  }
}

class DisplayData {
  final String name;
  final String description;
  final String iconUrl;

  DisplayData({required this.name, required this.description, required this.iconUrl});

  factory DisplayData.fromJson(Map<String, dynamic> json) {
    return DisplayData(
      name: json['name'],
      description: json['description'],
      iconUrl: json['icon_url'],
    );
  }
}
