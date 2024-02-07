using {com.test.sdb as db} from '../db/schema';
service Market{
    entity Business_Partner as projection on db.Business_Partner;
    entity States as projection on db.States;
}
annotate Market.Business_Partner with @odata.draft.enabled;
annotate Market.Business_Partner with {
    pinCode: @assert.format:'^[1-9]{1}[0-9]{2}\\s{0, 1}[0-9]{3}$';
}

annotate Market.Business_Partner with @(
UI.LineItem:[

    {
        Label:'Bussiness Partner Id',
        Value:bp_no
    },
    {
        Label:'Name',
        Value:name
    },
        {
        Label:'Address 1',
        Value:add1
    },
     {
        Label:'Address 2',
        Value:add2
    },
     {
        Label:'City',
        Value:city
    },
      {
        Label:'Is_gstn_registered'
        Value:Is_gstn_registered
    },
      {
        Label:'GSTIN Number'
        Value:Gst_num
    },
]
)