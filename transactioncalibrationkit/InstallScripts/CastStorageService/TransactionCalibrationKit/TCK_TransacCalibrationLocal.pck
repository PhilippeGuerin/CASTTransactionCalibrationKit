<?xml version="1.0" encoding="iso-8859-1"?>
<Package	PackName = "TCK_TransacCalibrationLOCAL"
			Type = "INTERNAL"
 			Version ="1.9.6"
			SupportedServer = "ALL"
			Display="TCK"
			Description="SME KIT - Transaction Calibration Kit"
      DatabaseKind="KB_LOCAL" >
	<Include>
		<PackName>DSSAPP_LOCAL</PackName>
		<Version>7.3.0</Version>
 	</Include>
	<Exclude>
	</Exclude>
	<Install>
	     <Step Type="PROC" Option="4" File="TCK_LocalCustomProcedures.sql" />
	</Install>
	<Update>
	</Update>
	<Refresh>
		<Step Type="PROC" Option="4" File="TCK_LocalProcedures.sql" />
	    <Step Type="PROC" File="TCK_ActivateTCCcustom.sql" />
	</Refresh>
	<Remove>
			<Step Type="PROC" Option="4" File="TCK_CleanLocalProcedures.sql" />
			<Step Type="PROC" Option="4" File="TCK_CleanLocalCustomProcedures.sql" />
	        <Step Type="PROC" File="TCK_DeActivateTCCcustom.sql" />
	</Remove>
</Package>