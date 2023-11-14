#ifndef RADAR_H
#define RADAR_H

#include <QObject>
#include <QAbstractListModel>
#include <QGeoCoordinate>
#include <QDebug>

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

    Q_INVOKABLE QGeoCoordinate findFirstVertex(const QGeoCoordinate &coordinate);

    Q_INVOKABLE QGeoCoordinate findSecondVertex(const QGeoCoordinate &coordinate);



private:
    QList<QGeoCoordinate> m_coordinates;
};

#endif // RADAR_H
