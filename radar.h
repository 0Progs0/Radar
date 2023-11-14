#ifndef RADAR_H
#define RADAR_H

#include <QObject>
#include <QAbstractListModel>
#include <QGeoCoordinate>
#include <QDebug>

//class Radar : public QObject
//{
//    Q_OBJECT
//    Q_PROPERTY(double latitude READ latitude WRITE setLatitude NOTIFY latitudeChanged)
//    Q_PROPERTY(double longitude READ longitude WRITE setLongitude NOTIFY longitudeChanged)


//public:
//    explicit Radar(QObject *parent = nullptr);
//    double latitude() const;
//    void setLatitude(double latitude);
//    double longitude() const;
//    void setLongitude(double longitude);

//signals:
//    void latitudeChanged(double latitude);
//    void longitudeChanged(double longitude);

//private:
//    double m_latitude;
//    double m_longitude;
//};
class Radar : public QAbstractListModel
{
    Q_OBJECT

public:
    using QAbstractListModel::QAbstractListModel;
    enum MarkerRoles {
        positionRole = Qt::UserRole + 1
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role) const override;

    QHash<int, QByteArray> roleNames() const override;


    Q_INVOKABLE void addMarker(const QGeoCoordinate &coordinate);

    Q_INVOKABLE void removeMarker(const QGeoCoordinate &coordinate);

    Q_INVOKABLE QGeoCoordinate findFirstVertex(const QGeoCoordinate &coordinate);

    Q_INVOKABLE QGeoCoordinate findSecondVertex(const QGeoCoordinate &coordinate);



private:
    QList<QGeoCoordinate> m_coordinates;
};

#endif // RADAR_H
