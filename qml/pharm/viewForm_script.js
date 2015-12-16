
function selectAllChecks() {
    barcode_check.checked = true
    name_check.checked = true
    scientificName_check.checked = true
    tags_check.checked = true
    sellingPrice_check.checked = true
    invoicePrice_check.checked = true
    amount_check.checked = true
    bonus_check.checked = true
    expiry_check.checked = true
    place_check.checked = true
    image_check.checked = true
    discription_check.checked = true
}

function deselectAllChecks() {
    barcode_check.checked = false
    name_check.checked = false
    scientificName_check.checked = false
    tags_check.checked = false
    sellingPrice_check.checked = false
    invoicePrice_check.checked = false
    amount_check.checked = false
    bonus_check.checked = false
    expiry_check.checked = false
    place_check.checked = false
    image_check.checked = false
    discription_check.checked = false
}

function showItemInfo() {

    if(barcode_check.checked)
        barcode_lbl.text = "<font color='red'>Barcode: </font>" + pharmItem.barcode

    if(name_check.checked)
        name_lbl.text = "<font color='red'>Name: </font>" +pharmItem.name

    if(scientificName_check.checked)
        scientificName_lbl.text = "<font color='red'>Scientific Name: </font>" + pharmItem.scientificName

    if(tags_check.checked) {
        var tags_txt = ""
        for(var i=0; i < pharmItem.tags.length; i++) {
            if(i !== pharmItem.tags.length-1) {
                tags_txt += "<font color='blue'>- " + pharmItem.tags[i] + "</font><br/>"
            } else {
                tags_txt += "<font color='blue'>- " + pharmItem.tags[i] + "</font>"
            }
            tags_lbl.text = "<font color='red'>Tags: </font><br/>" + tags_txt
        }
    }

    if(sellingPrice_check.checked)
        sellingPrice_lbl.text = "<font color='red'>Selling price: </font>" + pharmItem.sellingPrice

    if(invoicePrice_check.checked)
        invoicePrice_lbl.text = "<font color='red'>Invoice price: </font>" + pharmItem.invoicePrice

    if(amount_check.checked)
        amount_lbl.text = "<font color='red'>Amount: </font>" + pharmItem.amount

    if(bonus_check.checked)
        bonus_lbl.text = "<font color='red'>Bonus: </font>" + pharmItem.bonus

    if(expiry_check.checked)
        expiry_lbl.text = "<font color='red'>Expiry Date: </font>" + "<font color='blue'>Year: </font>" + pharmItem.expiryDate.getFullYear() + ", <font color='blue'>Month: </font>" + pharmItem.expiryDate.getMonth();

    if(place_check.checked) {
        viewPlace_btn.visible = true
        // connect click event to slot
    }

    if(image_check.checked) {
        item_img.source = pharmItem.imagePath
        item_img.visible = true
    }

    if(discription_check.checked)
        discription_lbl.text = "<font color='red'>Discription: </font>" + pharmItem.discription

}

function deleteItem() {
    PharmData.deleteItem(pharmItem.barcode);
    updateListModel();
    deselectAllChecks();
    showItemInfo();
    selectAllChecks();
}
