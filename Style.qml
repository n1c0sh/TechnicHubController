pragma Singleton
import QtQuick 2.9
import QtQuick.Controls.Material 2.4
import "."

QtObject{
    id:root

    // FONTS
    property string robotoCondensed: regularFont.name
    property FontLoader regularFont: FontLoader { source: "fonts/RobotoCondensed-Regular.ttf" }

    // COLORS

    property color dark_background: Material.color(Material.Grey, Material.Shade900);
    property color dark_primary: Material.color(Material.Grey, Material.Shade700);
    property color dark_accent: Material.color(Material.Teal, Material.Shade400);
    property color dark_foreground: Material.color(Material.Grey, Material.Shade300);

    property color light_background: Material.color(Material.Grey, Material.Shade200);
    property color light_primary: Material.color(Material.Grey, Material.Shade400);
    property color light_accent: Material.color(Material.Teal, Material.Shade400);
    property color light_foreground: Material.color(Material.Grey, Material.Shade900);


    // NUMERIC VARIABLES

}

