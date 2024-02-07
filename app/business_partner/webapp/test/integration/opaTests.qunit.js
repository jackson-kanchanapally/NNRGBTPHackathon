sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'businesspartner/test/integration/FirstJourney',
		'businesspartner/test/integration/pages/Business_PartnerList',
		'businesspartner/test/integration/pages/Business_PartnerObjectPage'
    ],
    function(JourneyRunner, opaJourney, Business_PartnerList, Business_PartnerObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('businesspartner') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheBusiness_PartnerList: Business_PartnerList,
					onTheBusiness_PartnerObjectPage: Business_PartnerObjectPage
                }
            },
            opaJourney.run
        );
    }
);