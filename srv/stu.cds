using {com.test.sdb as db} from '../db/schema';

service Market {
    entity Business_Partner as
        projection on db.Business_Partner {
            @UI.Hidden: true
            ID,
            *
        };

    entity States           as projection on db.States;

    entity Store            as
        projection on db.Store {
            @UI.Hidden: true
            ID,
            *
        };

    entity Product          as
        projection on db.Product {
            @UI.Hidden: true
            ID,
            *
        };

    entity Stock            as
        projection on db.Stock {
            @UI.Hidden: true
            ID,
            *
        };

    // entity Items            as projection on db.Items{
    //         @UI.Hidden: true
    //         ID,
    //         *
    //     };
    entity PurchaseApp      as
        projection on db.PurchaseApp {
            @UI.Hidden: true
            ID,
            *
        };
    entity SalesApp      as
        projection on db.PurchaseApp {
            @UI.Hidden: true
            ID,
            *
        };
}

annotate Market.Business_Partner with @odata.draft.enabled;
annotate Market.Store with @odata.draft.enabled;
annotate Market.Product with @odata.draft.enabled;
annotate Market.Stock with @odata.draft.enabled;
annotate Market.PurchaseApp with @odata.draft.enabled;
annotate Market.SalesApp with @odata.draft.enabled;
// annotate Market.Items with @odata.draft.enabled;

annotate Market.Business_Partner with {
    pinCode @assert.format: '^[1-9]{1}[0-9]{2}\\s{0, 1}[0-9]{3}$';
    Gst_num @assert.format: '^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[Z]{1}[0-9]{1}$';
}

annotate Market.Product with {
    imageURL @assert.format: '^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$';

}

annotate Market.States with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: code
    },
    {
        $Type: 'UI.DataField',
        Value: description
    },
],

);

annotate Market.Business_Partner with @(
    UI.LineItem             : [

        {
            Label: 'Bussiness Partner Id',
            Value: bp_no
        },
        {
            Label: 'Name',
            Value: name
        },
        {
            Label: 'Address 1',
            Value: add1
        },
        {
            Label: 'Address 2',
            Value: add2
        },
        {
            Label: 'City',
            Value: city
        },
        {
            Label: 'State',
            Value: state_code
        },
        {
            Label: 'Is_gstn_registered',
            Value: Is_gstn_registered
        },
        {
            Label: 'GSTIN Number',
            Value: Gst_num
        },
    ],
    UI.FieldGroup #BusinessP: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Bussiness Partner Id',
                Value: bp_no
            },
            {
                $Type: 'UI.DataField',
                Value: name
            },
            {
                $Type: 'UI.DataField',
                Value: add1
            },
            {
                $Type: 'UI.DataField',
                Value: add2
            },
            {
                $Type: 'UI.DataField',
                Value: city
            },
            {
                $Type: 'UI.DataField',
                Value: pinCode
            },
            {
                $Type: 'UI.DataField',
                Value: state_code
            },
            {Value: Is_gstn_registered},
            {
                $Type: 'UI.DataField',
                Value: Gst_num
            },
        ],
    },
    UI.Facets               : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'BusinessPFacet',
        Label : 'BusinessP',
        Target: '@UI.FieldGroup#BusinessP',
    }, ],
);


annotate Market.Store with @(
    UI.LineItem         : [
        {
            Label: 'Store Id',
            Value: store_id
        },
        {
            Label: 'Store name',
            Value: name
        },
        {
            Label: 'Address 1',
            Value: add1
        },
        {
            Label: 'Address 2',
            Value: add2
        },
        {
            Label: 'City',
            Value: city
        },
        {
            Label: 'State',
            Value: state_code
        },
        {
            Label: 'Pin code',
            Value: PinCode
        },
    ],
    UI.FieldGroup #store: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Label: 'Store Id',
                Value: store_id
            },
            {
                Label: 'Store name',
                Value: name
            },
            {
                Label: 'Address 1',
                Value: add1
            },
            {
                Label: 'Address 2',
                Value: add2
            },
            {
                Label: 'City',
                Value: city
            },
            {
                Label: 'State',
                Value: state_code
            },
            {
                Label: 'Pin code',
                Value: PinCode
            },
        ],
    },
    UI.Facets           : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'storeFacet',
        Label : 'store facets',
        Target: '@UI.FieldGroup#store'
    }, ],
);

// annotate Market.Product with {
//     @Common.Text:'{name}'
//     @Core.MediaType:'image/jpg'
//     imageURL
// };
annotate Market.Product with @(
    UI.LineItem           : [
        {
            Label: 'Product id',
            Value: p_id
        },
        {
            Label: 'Product Name',
            Value: name
        },
        {
            Label: 'Product Image URL',
            $Type: 'UI.DataField',
            Value: imageURL
        },
        {
            Label: 'Cost Price',
            Value: costPrice
        },
        {
            Label: 'Sell Price',
            Value: sellPrice
        },
    ],
    UI.FieldGroup #product: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Label: 'Product id',
                Value: p_id
            },
            {
                Label: 'Product Name',
                Value: name
            },
            {
                Label: 'Product Image URL',
                Value: imageURL
            },
            {
                Label: 'Cost Price',
                Value: costPrice
            },
            {
                Label: 'Sell Price',
                Value: sellPrice
            },
        ],
    },
    UI.Facets             : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'productFacet',
        Label : 'product facets',
        Target: '@UI.FieldGroup#product'
    }, ],

);

annotate Market.Stock with @(
    UI.LineItem         : [
        {
            Label: 'Store Id',
            Value: storeId_ID
        },
        {
            Label: 'Product Id',
            Value: productId_ID
        },
        {
            Label: 'Stock Quantity',
            Value: stock_qty
        }
    ],
    UI.FieldGroup #stock: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Label: 'Store Id',
                Value: storeId_ID
            },
            {
                Label: 'Product Id',
                Value: productId_ID
            },
            {
                Label: 'Stock Quantity',
                Value: stock_qty
            }
        ],
    },
    UI.Facets           : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'stockFacet',
        Label : 'stock facets',
        Target: '@UI.FieldGroup#stock'
    }, ],
);

// annotate Market.Items with @(
//     UI.LineItem     : [
//         // {
//         //     Label: 'Store Id',
//         //     Value: storeId_ID
//         // },
//         {
//             Label: 'Quantity',
//             Value: qty
//         },
//         {
//             Label: 'Price',
//             Value: price
//         },
//     ],
//     UI.FieldGroup #items: {
//         $Type: 'UI.FieldGroupType',
//         Data : [
//             // {
//             //     Label: 'Store Id',
//             //     Value: storeId_ID
//             // },
//             {
//                 Label: 'Quantity',
//                 Value: qty
//             },
//             {
//                 Label: 'Price',
//                 Value: price
//             },
//         ],
//     },
//     UI.Facets           : [{
//         $Type : 'UI.ReferenceFacet',
//         ID    : 'itemsFacet',
//         Label : 'items',
//         Target: '@UI.FieldGroup#items',
//     }, ],
// );

annotate Market.PurchaseApp with @(
    UI.LineItem          : [
        {
            Label: 'Purchase Order Number',
            Value: pon
        },
        {
            Label: 'Business Partner',
            Value: bp_ID
        },
        {
            Label: 'Product purchase Date',
            Value: pDate
        },
        {
            Label: 'Store Id',
            Value: store.name
        },
        {
            Label: 'Product Name',
            Value: Items.product.name,
        },
        {
            Label: 'Price',
            Value: Items.price,
        },
        {
            Label: 'Quantity',
            Value: Items.qty,
        },

    ],
    UI.FieldGroup #purApp: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Label: 'Purchase Order Number',
                Value: pon
            },
            {
                Label: 'Business Partner',
                Value: bp_ID
            },
            {
                Label: 'Product purchase Date',
                Value: pDate
            },
            {
                Label: 'Store Id',
                Value: store_ID
            },
        ],
    },
    UI.Facets            : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'purAppFacet',
            Label : 'purApp facets',
            Target: '@UI.FieldGroup#purApp'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'purchaseItemFacet',
            Label : ' facets',
            Target: 'Items/@UI.LineItem'
        },
    ],
);
// annotate Market.SalesApp with @(
//     UI.LineItem          : [
//         {
//             Label: 'Sales Order Number',
//             Value: son
//         },
//         {
//             Label: 'Business Partner',
//             Value: bp_ID
//         },
//         {
//             Label: 'Sales purchase Date',
//             Value: sDate
//         },
//         {
//             Label: 'Store Id',
//             Value: store.name
//         },
//         {
//             Label: 'Product Name',
//             Value: Items.product.name,
//         },
//         {
//             Label: 'Price',
//             Value: Items.price,
//         },
//         {
//             Label: 'Quantity',
//             Value: Items.qty,
//         },

//     ],
//     UI.FieldGroup #saleApp: {
//         $Type: 'UI.FieldGroupType',
//         Data : [
//             {
//                 Label: 'Purchase Order Number',
//                 Value: son
//             },
//             {
//                 Label: 'Business Partner',
//                 Value: bp_ID
//             },
//             {
//                 Label: 'Product purchase Date',
//                 Value: sDate
//             },
//             {
//                 Label: 'Store Id',
//                 Value: store_ID
//             },
//         ],
//     },
//     UI.Facets            : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID    : 'salesAppFacet',
//             Label : 'salesApp facets',
//             Target: '@UI.FieldGroup#saleApp'
//         },
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID    : 'saleItemFacet',
//             Label : ' facets',
//             Target: 'Items/@UI.LineItem'
//         },
//     ],
// );

annotate Market.PurchaseApp.Items with @(
    UI.LineItem               : [
        // {Value: ID},
        {Value: product_ID},
        {Value: qty},
        {Value: price},


    ],
    UI.FieldGroup #purAppitems: {
        $Type: 'UI.FieldGroupType',
        Data : [
            // {Value: ID},
            {
                Label: 'Product Id',
                Value: product_ID
            },
            {
                Label: 'Quantity',
                Value: qty
            },
            {
                Label: 'Product Price',
                Value: price
            },
        ],
    },
    UI.Facets                 : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'purAppitemsFacet',
        Label : 'purAppitems',
        Target: '@UI.FieldGroup#purAppitems',
    }, ]

);


annotate Market.Business_Partner with {
    state @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'State',
            CollectionPath: 'States',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: state_code,
                    ValueListProperty: 'code'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description'
                },
            ]
        }
    );
};

annotate Market.Store with {
    state @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'State',
            CollectionPath: 'States',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: state_code,
                    ValueListProperty: 'code'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description'
                },
            ]
        }
    );
};

annotate Market.PurchaseApp with {
    bp    @(
        Common.Text                    : bp.name,
        Common.TextArrangement:#TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'State',
            CollectionPath: 'Business_Partner',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: bp_ID,
                    ValueListProperty: 'ID'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },
            ]
        }
    );
    store @(
        Common.Text                    : store.name,
        Common.TextArrangement         : #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'store_id',
            CollectionPath: 'Store',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'store_ID',
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        }

    )

};

annotate Market.Stock with {
    storeId   @(
        Common.ValueListWithFixedValues: true,
        
        Common.ValueList               : {
            Label         : 'Store id',
            CollectionPath: 'Store',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: storeId_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },

            ]
        }
    );
    productId @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'Product id',
            CollectionPath: 'Product',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: productId_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },

            ]
        }
    );
}

// annotate Market.PurchaseApp.Items with {
//     Items  @(

//            Common.Text:item.productId.name,
//         // Common.ValueListWithFixedValues: true,
//         Common.ValueList               : {
//             Label         : 'Product',
//             CollectionPath: 'Items',
//             Parameters    : [
//                 {
//                     $Type            : 'Common.ValueListParameterInOut',
//                     LocalDataProperty: item_ID,
//                     ValueListProperty: 'ID'
//                 },
//                 {
//                     $Type            : 'Common.ValueListParameterInOut',
//                     ValueListProperty: 'productId_ID',
//                     LocalDataProperty: '
//                 },
//                 {
//                     $Type            : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty: 'productId_ID'
//                 },

//             ]
//         }
//     );
// }
annotate Market.PurchaseApp.Items with {
    product @(
        Common.Text     : product.name,
          Common.TextArrangement:#TextOnly,
        // Common.ValueListWithFixedValues: true,
        Common.ValueList: {
            Label         : 'product',
            CollectionPath: 'Product',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: product_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },

            ]
        }
    );
};

annotate Market.Product with {
    @Common.Text   : '{Product}'
    @Core.IsURL    : true
    @Core.MediaType: 'image/jpg'
    imageURL
};
