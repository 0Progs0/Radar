import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Styles 1.4
import QtLocation 5.12
import QtQuick.Shapes 1.12
import Radar 1.0


Map{
        anchors.fill: parent
        plugin: Plugin {
            name: "osm"
        }

        center {
            latitude: 59.95
            longitude: 30.33
        }

        zoomLevel: 13
    MapPolygon {
    id: knItem
    color: "red"
    path : [{latitude:59.91288302222718, longitude:30.728799819940349},
                                                            {latitude:59.91821810440818, longitude:30.737211227411649},
                                                            {latitude:59.912323649434825, longitude:30.754119873037723}]
}
}
