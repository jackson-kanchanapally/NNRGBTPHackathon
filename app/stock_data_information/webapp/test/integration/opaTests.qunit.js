sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'stockdatainformation/test/integration/FirstJourney',
		'stockdatainformation/test/integration/pages/StockList',
		'stockdatainformation/test/integration/pages/StockObjectPage'
    ],
    function(JourneyRunner, opaJourney, StockList, StockObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('stockdatainformation') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheStockList: StockList,
					onTheStockObjectPage: StockObjectPage
                }
            },
            opaJourney.run
        );
    }
);