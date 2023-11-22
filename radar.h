#ifndef RADAR_H
#define RADAR_H

#include <QObject>
#include <QAbstractListModel>
#include <QGeoCoordinate>
#include <QDebug>
#include <QTcpSocket>

class Radar : public QAbstractListModel
{
    Q_OBJECT

public:

    explicit Radar (QObject *parent = nullptr);

    using QAbstractListModel::QAbstractListModel;
    enum MarkerRoles {
        positionRole = Qt::UserRole + 1
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role) const override;

    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void connectToServer();

    void slotReadyRead();

    Q_INVOKABLE void sendToServer(QGeoCoordinate str);

    Q_INVOKABLE void addCoord(const QGeoCoordinate &coordinate);

    Q_INVOKABLE QGeoCoordinate findFirstVertex(const QGeoCoordinate &coordinate);

    Q_INVOKABLE QGeoCoordinate findSecondVertex(const QGeoCoordinate &coordinate);

private:
    QList<QGeoCoordinate> m_coordinates;
    QTcpSocket *socket = new QTcpSocket (this);
    QByteArray d_array;
    qint16 nextBlockSize = 0;
};

#endif // RADAR_H
