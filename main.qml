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

        ListElement {
            coordsArray : [
                    ListElement {
                    latitude:59.91288302222718
                    longitude:30.728799819940349
                    },
                    ListElement {
                    latitude:59.91821810440818
                    longitude:30.737211227411649
                    },
                    ListElement {
                    latitude:59.912323649434825
                    longitude:30.754119873037723
                    }
                   ]
        }
    }

    ListView {
            anchors.fill: parent
            model: polygonModel
            delegate: polygonDelegate
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
                polygonModel.set(0,{coordsArray : list})
//                polygonModel.append({coordsArray : list}) //ломает отрисовку у Repeater
                }
            }
        }



        Repeater {
            id:polygonDelegate
            model : polygonModel

            MapPolygon {
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
