<?xml version="1.0" encoding="iso-8859-1"?>
<Package	PackName = "TCK_LOCAL"
			Type = "INTERNAL"
 			Version ="1.7.11"
			SupportedServer = "ALL"
			Display="TCK"
			Description="Automated Fonction Points - Calibration kit"
      DatabaseKind="KB_LOCAL" >
	<Include>
		<PackName>DSSAPP_LOCAL</PackName>
		<Version>7.3.0</Version>
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
			<Step Type="PROC" Option="4" File="TCK_CleanLocalProcedures.sql" />
	        <Step Type="PROC" File="TCK_DeActivateTCCcustom.sql" />
	</Remove>
</Package>