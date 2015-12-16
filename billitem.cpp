#include "billitem.h"

BillItem::BillItem(QObject *parent) :
    QObject(parent)
{
}

BillItem::BillItem(const BillItem &item)
{
    _barcode = item.barcode();
    _sellingPrice = item.sellingPrice();
    _invoicePrice = item.invoicePrice();
    _amount = item.amount();
}

BillItem::BillItem(QString barcode, int sellingPrice, int invoicePrice, int amount, QObject *parent) :
     _barcode(barcode), _sellingPrice(sellingPrice), _invoicePrice(invoicePrice),  _amount(amount), QObject(parent)
{

}

BillItem &BillItem::operator=(const BillItem &item)
{
    _barcode = item.barcode();
    _sellingPrice = item.sellingPrice();
    _invoicePrice = item.invoicePrice();
    _amount = item.amount();
    return *this;
}
