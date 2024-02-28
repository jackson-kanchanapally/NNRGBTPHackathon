const cds = require('@sap/cds')

module.exports = cds.service.impl(async function () {
    const { States, Business_Partner,Product, PurchaseApp, Stock, Items } = this.entities;

    this.on("READ", Business_Partner, async (req) => {
        const results = await cds.run(req.query);
        return results;
    });
    this.on("READ", Product, async (req) => {
        const results = await cds.run(req.query);
        return results;
    });
    this.on("READ", PurchaseApp, async (req) => {
        const results = await cds.run(req.query);
        return results;
    });

    this.before("CREATE", Business_Partner, async (req) => {
        const { bp_no, Is_gstn_registered, Gst_num } = req.data;
        if (Is_gstn_registered && !Gst_num) {
            req.error({
                code: "MISSING_GST_NUM",
                message: "GSTIN number is mandatory when Is_gstn_registered is true",
                target: "Gst_num",
            });
        }
        const existingBP = await cds.run(SELECT.from(Business_Partner).where({ bp_no: req.data.bp_no }));
        if (existingBP.length > 0) {
            req.error({
                code: "BP_EXISTS",
                message: "Business partner already exists",
                target: "bp_no",
            });
        }
    });

    this.before("CREATE",PurchaseApp,async(req)=>{
        const {Items}=req.data
        for (const item of Items){
            const products=await cds.read(Product).where({ ID: item.product_ID});
            const costPrice=parseFloat(products[0].costPrice)
            const price=parseFloat(item.price)
            if(price<costPrice){
                req.error({
                    code:"COSTPRICEERR",
                    message:"The purchase price is less than the price of cost price",
                    target:'Items'
                })
            }
        }
    })

    this.on('READ', States, async (req) => {
        const states = [
            { "code": "TS", "description": "Telangana" },
            { "code": "AP", "description": "Andra Pradesh" },
            { "code": "TN", "description": "Tamil Nadu" },
        ];
        states.$count = states.length;
        return states;
    });
})
