import QtQuick 2.6
import QtQuick.Controls 1.5
import QtLocation 5.6

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ListModel {
        id: polygonModel


    }


    Map {
        id:map
        anchors.fill: parent
        plugin: Plugin { name: "osm" }

        center {
            latitude: 59.95
            longitude: 30.33
        }


        zoomLevel: 6


        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            onClicked: {
                if (mouse.button == Qt.LeftButton) {

                    var coordinate = map.toCoordinate(Qt.point(mouse.x,mouse.y))
                    var secondCoord = radar.findFirstVertex(coordinate)
                    var thirdCoord = radar.findSecondVertex(coordinate)
                    var list = [
                                {latitude:coordinate.latitude, longitude:coordinate.longitude},
                                {latitude:secondCoord.latitude, longitude:secondCoord.longitude},
                                {latitude:thirdCoord.latitude, longitude:thirdCoord.longitude}
                              ]
                polygonModel.append({coordsArray : list}) //ломает отрисовку у Repeater
                }
            }
        }


        MapItemView {
                model: polygonModel
                delegate:MapPolygon {
                color: "red"
                path: [
                       polygonModel.get(index).coordsArray.get(0),
                       polygonModel.get(index).coordsArray.get(1),
                       polygonModel.get(index).coordsArray.get(2)
                ]

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.RightButton
                    onClicked: {
                        if (mouse.button == Qt.RightButton) {
                        polygonModel.remove(index)


                        }
                    }
                }
            }


            }
    }
}
