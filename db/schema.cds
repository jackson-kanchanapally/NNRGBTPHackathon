namespace com.test.sdb;

using {cuid} from '@sap/cds/common';

@assert.unique: {bp_no: [bp_no]}
entity Business_Partner {
    key ID                 : UUID;
        bp_no              : String(6);

        @title: 'Name'
        name               : String(20);

        @title: 'Address 1'
        add1               : String(70);

        @title: 'Address 2'
        add2               : String(70);

        @title: 'City'
        city               : String(20);

        @title: 'State'
        state              : Association to States;

        @title: 'pin code'
        pinCode            : String(10);

        @title: ' Is_gstn_registered'
        Is_gstn_registered : Boolean default false;

        @title: ' GSTIN number'
        Gst_num            : String(20);

        @title: ' is vendor'
        Is_vendor          : Boolean default false;

        @title: ' is customer'
        Is_customer        : Boolean default false;
}

entity Store {
    key ID       : UUID;
        store_id : String(10);
        name     : String(100);
        add1     : String(255);
        add2     : String(255);
        city     : String(100);
        state    : Association to States;
        PinCode  : String(10) @(assert.format: '^[1-9][0-9]{5}$');
}

entity Product {
    key ID        : UUID;
        p_id      : String(20);
        name      : String(100);
        imageURL  : String default 'https://009368a1548c63ca891d-094bbc518b6110936532ec111f02d360.ssl.cf2.rackcdn.com/product-original-380897-114944-1413874392-c61b74c804a863d4b7bfb1465fd3a7b2.413874393_type_original_nid_380897_uid_114944_2';
        costPrice : Decimal(15, 2);
        sellPrice : Decimal(15, 2);
}


entity Stock {
    key ID        : UUID;
        storeId   : Association to Store;
        productId : Association to Product;
        stock_qty : Integer;
}

entity PurchaseApp {
    key ID    : UUID;
        pon   : Integer;
        bp    : Association to Business_Partner;
        pDate : Date;
        store : Association to Store;
        // Items : Composition of many Items;
        
        Items : Composition of many {
                    key ID        : UUID;
                        qty       : Integer;
                        product : Association to Product;
                        price     : Integer;
                };
}

// entity Items {
//     key ID        : UUID;
//         qty       : Integer;
//         productId : Association to Product;
//         price     : Integer;
// }

entity SalesApp {
    key ID :UUID;
    son:Integer;
    bp:Association to Business_Partner;
     sDate : Date;
        store : Association to Store;
      Items : Composition of many {
                    key ID        : UUID;
                        qty       : Integer;
                        product : Association to Product;
                        price     : Integer;
                };
}
@cds.persistence.skip
entity States {
        @title: 'code'
        key code        : String(3);
        @title: 'description'
        description : String(10);

}
