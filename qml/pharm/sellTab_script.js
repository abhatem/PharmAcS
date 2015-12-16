
function addToBillList(barcode) {
    var pi = getPharmItem(barcode)
    if(pi !== null) {
        var li_index = getListItem(barcode)
        if(li_index === null) {
            lm.append({"name": pi.name, "sellingPrice": pi.sellingPrice, "amount": 1, "totalPrice": pi.sellingPrice, "barcode": pi.barcode})
        } else {
            if(pi.amount > lm.get(li_index).amount) {
                lm.get(li_index).amount++;
                lm.get(li_index).totalPrice = lm.get(li_index).sellingPrice * lm.get(li_index).amount
            } else {
                noMoreItems_box.show(pi.name, pi.amount);
            }

        }
    } else {
        console.log("No item having the barcode ", barcode, " has been found");
    }

    sellForm.clearBarcodeTxt();
}

function getPharmItem(barcode) {
    for(var i=0; i < PharmData.pharmItems.length; i++) {
        if(PharmData.pharmItems[i].barcode === barcode) return PharmData.pharmItems[i];
    }
    return null
}

function getListItem(barcode) {

    for(var i=0; i < lm.count; i++) {
        if(lm.get(i).barcode === barcode) return i

    }
    return null
}


function saveBill(disc) {
//    lm.forEach(function(i){
//                   pb.addItem(i.barcode, i.sellingPrice, i.invoicePrice, i.amount);
//               });
    for(var i=0; i < lm.count; i++) {
        pb.addItem(lm.get(i).barcode, lm.get(i).sellingPrice, lm.get(i).invoicePrice, lm.get(i).ammount);
    }

    pb.setDiscription(disc);
    PharmData.saveBill(pb);
}
