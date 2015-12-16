#ifndef PHARMDATA_H
#define PHARMDATA_H

#include <QObject>
#include <QtSql>
#include "pharmitem.h"
#include "pharmbill.h"

class PharmData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<QObject*> pharmItems READ pharmItems NOTIFY pharmItemsChanged)
    Q_PROPERTY(QList<QUrl> placesPaths  READ placesPaths NOTIFY placesPathsChanged)

public:
    explicit PharmData(QObject *parent = 0);
    ~PharmData();

signals:
    void pharmItemsChanged();
    void placesPathsChanged();
public slots:
    QList<QObject*> pharmItems() {return _pharmItems;}
    QList<QUrl> placesPaths() {return _placesPaths;}
//    void writeItem(QString &barcode, QString &name, QString &scientificName, QString &discription,
//                    QString &imagePath, int sellingPrice, int invoicePrice, int amount,
//                   int bonus, QDate &expiryDate, int posX, int posY, int place_id);
    void loadPharmItems();
    void loadPlacesPaths();
    bool fileExists(QUrl filename);
    void addPlacePath(QUrl url);
    void deletePlacePath(QUrl url);
//    void insertItem(PharmItem item);
    void insertItem(QString barcode, QString name, QString scientificName, QString discription, QUrl imagePath, int sellingPrice, int invoicePrice, int amount, int bonus, QDate expiryDate, QUrl placePath,  int posX, int posY, QStringList tags);
    void saveBill(QObject *bill_obj);
    bool deleteItem(QString barcode);
//    void insertItem(); to be add later with the right arguments
    void updateItem(QString barcode, QString name, QString scientificName, QString discription, QUrl imagePath, int sellingPrice, int invoicePrice, int amount, int bonus, QDate expiryDate, QUrl placePath,  int posX, int posY, QStringList tags);
    void updateItem(PharmItem item);

private:
    QList<QObject*> _pharmItems;
    QList<QUrl> _placesPaths;
    QSqlDatabase db;

};

#endif // PHARMDATA_H
