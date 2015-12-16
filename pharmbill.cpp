#include "pharmbill.h"

PharmBill::PharmBill(QObject *parent) :
    QObject(parent)
{
}

void PharmBill::addItem(QString barcode, int sellingPrice, int invoicePrice, int amount)
{
    BillItem item(barcode, sellingPrice, invoicePrice, amount);
    _billItems.append(item);
}

void PharmBill::addItem(BillItem &i)
{
    _billItems.append(i);
}

void PharmBill::saveBill()
{
    //PharmData.saveBill(*this);
}




