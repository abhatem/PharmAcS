#include "pharmitem.h"

PharmItem::PharmItem(QObject *parent) :
    QObject(parent)
{
}

PharmItem::PharmItem(QString &barcode, QString &name, QString &scientificName, QString &discription, QUrl &imagePath, int sellingPrice, int invoicePrice, int amount, int bonus, QDate &expiryDate, QStringList &tags, int posX, int posY, QUrl placePath, QObject *parent) :
    QObject(parent), _barcode(barcode), _name(name), _scientificName(scientificName), _discription(discription), _imagePath(imagePath), _sellingPrice(sellingPrice), _invoicePrice(invoicePrice), _amount(amount), _bonus(bonus), _expiryDate(expiryDate), _tags(tags), _posX(posX), _posY(posY), _placePath(placePath)
{

}

PharmItem::PharmItem(const PharmItem &pi) :
    QObject(pi.parent()), _barcode(pi.barcode()), _name(pi.name()), _scientificName(pi.scientificName()),
    _discription(pi.discription()),  _imagePath(pi.imagePath()), _sellingPrice(pi.sellingPrice()),
    _invoicePrice(pi.invoicePrice()),
    _amount(pi.amount()), _bonus(pi.bonus()),
    _expiryDate(pi.expiryDate()), _tags(pi.tags()), _posX(pi.posX()), _posY(pi.posY()),
    _placePath(pi.placePath())
{

}

PharmItem &PharmItem::operator=(const PharmItem &pi)
{
    _barcode = pi.barcode();
    _name = pi.name();
    _scientificName = pi.scientificName();
    _discription = pi.discription();
    _imagePath = pi.imagePath();
    _sellingPrice = pi.sellingPrice();
    _invoicePrice = pi.invoicePrice();
    _amount = pi.amount();
    _bonus = pi.bonus();
    _expiryDate = pi.expiryDate();
    _tags = pi.tags();
    _posX = pi.posX();
    _posY = pi.posY();
    _placePath = pi.placePath();
    return *this;
}

bool PharmItem::operator<(const PharmItem &other)
{
    if(_barcode < other.barcode()) return true;
    else return false;
}

//QList<int> PharmItem::pos()
//{
//    QList<int> ret;
//    ret.push_back(_posX);
//    ret.push_back(_posY);
//    ret.push_back(_placePath);
//    return ret;
//}

void PharmItem::setBarcode(const QString &barcode)
{
    if(barcode == _barcode) return;
    _barcode = barcode;
    emit barcodeChanged(barcode);
}

void PharmItem::setName(const QString &name)
{
    if(name == _name) return;
    _name = name;
    emit barcodeChanged(name);
}

void PharmItem::setScientificName(const QString &scientificName)
{
    if(scientificName == _scientificName) return;
    _scientificName = scientificName;
    emit scientificNameChanged(scientificName);
}

void PharmItem::setDiscription(const QString &discription)
{
    if(discription == _discription) return;
    _discription = discription;
    emit discriptionChanged(discription);
}

void PharmItem::setImagePath(const QUrl &imagePath)
{
    if(imagePath == _imagePath) return;
    _imagePath = imagePath;
    emit imagePathChanged(imagePath);
}

void PharmItem::setSellingPrice(const int sellingPrice)
{
    if(sellingPrice == _sellingPrice) return;
    _sellingPrice = sellingPrice;
    emit sellingPriceChanged(sellingPrice);
}

void PharmItem::setInvoicePrice(const int invoicePrice)
{
    if(invoicePrice == _invoicePrice) return;
    _invoicePrice = invoicePrice;
    emit invoicePriceChanged(invoicePrice);
}

void PharmItem::setAmount(const int amount)
{
    if(amount == _amount) return;
    _amount = amount;
    emit amountChanged(amount);
}

void PharmItem::setBonus(const int bonus)
{
    if(bonus == _bonus) return;
    _bonus = bonus;
    emit bonusChanged(bonus);
}

void PharmItem::setExpiryDate(const QDate &expiryDate)
{
    if(expiryDate == _expiryDate) return;
    _expiryDate = expiryDate;
    emit expiryDateChanged(expiryDate);
}

void PharmItem::setTags(const QStringList &tags)
{
    if(tags == _tags) return;
    _tags = tags;
    emit tagsChanged(tags);
}

void PharmItem::setTag(const int i, const QString &tag)
{
    if(i < _tags.size()){
        if(tag == _tags[i]) return;
        _tags[i] = tag;
        emit tagsChanged(_tags);
    } else return;
}

//void PharmItem::setPos(const QList<int> &pos)
//{
//    if(pos[0] != _posX){
//        _posX = pos[0];
//        emit posXChanged(pos[0]);
//    }

//    if(pos[1] != _posY){
//        _posY = pos[1];
//        emit posYChanged(pos[1]);
//    }

//    if(pos[2] != _placeId){
//        _placeId = pos[2];
//        emit placeIdChanged(pos[2]);
//    }
//}

void PharmItem::setPosX(const int posX)
{
    if(posX == _posX) return;
    _posX = posX;
    emit posXChanged(posX);
}

void PharmItem::setPosY(const int posY)
{
    if(posY == _posY) return;
    _posY = posY;
    emit posYChanged(posY);
}

void PharmItem::setPlacePath(const QUrl placePath)
{
    if(placePath == _placePath) return;
    _placePath = placePath;
    emit placePathChanged(placePath);
}

//void PharmItem::setPos(const QList<int> &pos)
//{
//    if(pos == _pos) return;
//    _pos = pos;
//    emit posChanged(pos);
//}

//void PharmItem::setPos(const int place_id, const int x, const int y)
//{
//    QList<int> l;
//    l.push_back(place_id);
//    l.push_back(x);
//    l.push_back(y);
//    if(l == _pos) return;
//    _pos = l;
//    emit posChanged(l);
//}






