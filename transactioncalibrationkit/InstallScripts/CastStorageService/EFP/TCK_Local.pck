<?xml version="1.0" encoding="iso-8859-1"?>
<Package	PackName = "TCK_LOCAL"
			Type = "INTERNAL"
 			Version ="1.7.1.0"
			SupportedServer = "ALL"
			Display="TCK"
			Description="Automated Fonction Points - Calibration kit"
      DatabaseKind="KB_LOCAL" >
	<Include>
 	</Include>
	<Exclude>
	</Exclude>
	<Install>
	</Install>
	<Update>
	</Update>
	<Refresh>
		<Step Type="PROC" Option="4" File="TCK_LocalProcedures.sql" />
	    <Step Type="PROC" File="TCK_ActivateTCCcustom.sql" />
	</Refresh>
	<Remove>
	</Remove>
</Package>