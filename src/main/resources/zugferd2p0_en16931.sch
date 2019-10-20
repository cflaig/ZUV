<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    schemaVersion="iso">
  <title>Schema for FACTUR-X; 1.0; EN16931-COMPLIANT (FULLY)</title>
  <ns uri="urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100" prefix="rsm"/>
  <ns uri="urn:un:unece:uncefact:data:standard:QualifiedDataType:100" prefix="qdt"/>
  <ns uri="urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100" prefix="ram"/>
  <ns uri="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:100" prefix="udt"/>
  <pattern>
    <rule context="//ram:AdditionalReferencedDocument">
      <assert test="(ram:IssuerAssignedID!=&apos;&apos;)">
	Jede rechnungsbegründende Unterlage muss einen Dokumentenbezeichner „Supporting document reference“ (BT-122) haben.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax">
      <assert test="(ram:BasisAmount)">
	Jede Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) muss die Summe aller nach dem jeweiligen Schlüssel zu versteuernden Beträge „VAT category taxable amount“ (BT-116) aufweisen.</assert>
      <assert test="(ram:CalculatedAmount)">
	Jede Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) muss den für die betreffende Umsatzsteuerkategorie zu entrichtenden Gesamtbetrag „VAT category tax amount“ (BT-117) aufweisen.</assert>
      <assert test="(ram:CategoryCode)">
	Jede Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) muss über eine codierte Bezeichnung einer Umsatzsteuerkategorie „VAT category code“ (BT-118) definiert werden.</assert>
      <assert test="(ram:RateApplicablePercent) or (ram:CategoryCode = &apos;O&apos;)">
	Jede Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) muss einen Umsatzsteuersatz gemäß einer Kategorie „VAT category rate“ (BT-119) haben. Sofern die Rechnung von der Umsatzsteuer ausgenommen ist, ist „0“ zu übermitteln.</assert>
      <assert test="((ram:TaxPointDate) and not (ram:DueDateTypeCode)) or (not (ram:TaxPointDate) and (ram:DueDateTypeCode)) or (not (ram:TaxPointDate) and not (ram:DueDateTypeCode))">
	Umsatzsteuerdatum „Value added tax point date“ (BT-7) und Code für das Umsatzsteuerdatum „Value added tax point date code“ (BT-8) schließen sich gegenseitig aus.</assert>
      <assert test="ram:CalculatedAmount = round(ram:BasisAmount * ram:RateApplicablePercent) div 100 +0 or not (ram:RateApplicablePercent)">
	Der Inhalt des Elementes „VAT category tax amount“ (BT-117) entspricht dem Inhalt des Elementes „VAT category taxable amount“ (BT-116), multipliziert mit dem Inhalt des Elementes „VAT category rate“ (BT-119) geteilt durch 100, gerundet auf zwei Dezimalstellen.</assert>
      <assert test="string-length(substring-after(ram:BasisAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the VAT category taxable amount (BT-116) is 2.</assert>
      <assert test="string-length(substring-after(ram:CalculatedAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the VAT category tax amount (BT-117) is 2.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[. = &apos;Z&apos;]">
      <assert test="../ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = &apos;Z&apos;]/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;Z&apos;]/ram:ActualAmount)*10*10)div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;Z&apos;]/ram:ActualAmount)*10*10)div 100)">
	In einer „VAT BREAKDOWN“ (BG-23), in der als Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) der Wert „Zero rated“ angegeben ist, muss der „VAT category taxable amount“ (BT-116) gleich der Summe der Informationselemente „Invoice line net amount“ (BT-131) abzüglich der „Document level allowance amount“ (BT-92) zuzüglich der „Document level charge amount“ (BT-99) sein, wobei als „Invoiced item VAT category code“ (BT-151), als „Document level allowance VAT category code“ (BT-95) sowie als „Document level charge VAT category code“ (BT-102) jeweils der Wert „Zero rated“ angegeben wird.</assert>
      <assert test="../ram:CalculatedAmount = 0">
	Der „VAT category tax amount“ (BT-117) muss in einer „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „Zero rated“ gleich „0“ sein.</assert>
      <assert test="not(../ram:ExemptionReason) and not (../ram:ExemptionReasonCode)">
	Ein „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „Zero rated“ darf keinen Code des Umsatzsteuerbefreiungsgrundes „VAT exemption reason code“ (BT-121) oder Text des Umsatzsteuerbefreiungsgrundes „VAT exemption reason text“ (BT-120) enthalten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[.=&apos;S&apos;]">
      <assert test="../ram:CalculatedAmount = round(../ram:BasisAmount * ../ram:RateApplicablePercent) div 100 +0">
	Der in der Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) angegebene Betrag der nach Kategorie zu entrichtenden Umsatzsteuer, bei dem als Umsatzsteuerkategorie der Wert „Standard rated“ angegeben ist, muss gleich dem mit dem kategoriespezifischen Umsatzsteuersatz multiplizierten nach der Umsatzsteuerkategorie zu versteuernden Betrag sein.</assert>
      <assert test="not(../ram:ExemptionReason) and not (../ram:ExemptionReasonCode)">
	Eine Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) in der als Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) der Wert „Standard rated“ angegeben ist, darf keinen Code des Umsatzsteuerbefreiungsgrundes „VAT exemption reason code“ (BT-121) oder Text des Umsatzsteuerbefreiungsgrundes „VAT exemption reason text“ (BT-120) enthalten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod">
      <assert test="(ram:EndDateTime/udt:DateTimeString[@format = &apos;102&apos;]) &gt;= (ram:StartDateTime/udt:DateTimeString[@format = &apos;102&apos;]) or not (ram:EndDateTime) or not (ram:StartDateTime)">
	Wenn Start- und Enddatum des Rechnungszeitraums gegeben sind, muss das Enddatum „Invoicing period end date“ (BT-74) nach dem Startdatum „Invoicing period start date“ (BT-73) liegen oder mit diesem identisch sein.</assert>
      <assert test="(ram:StartDateTime) or (ram:EndDateTime)">
	Wenn die Gruppe „INVOICING PERIOD“ (BG-14) verwendet wird, müssen entweder das Element „Invoicing period start date“ (BT-73) oder das Element „Invoicing period end date“ (BT-74) oder beide gefüllt sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos;]">
      <assert test="(ram:ActualAmount)">
	Jeder Nachlass für die Rechnung als Ganzes „DOCUMENT LEVEL ALLOWANCES“ (BG-20) muss einen Betrag „Document level allowance amount“ (BT-92) aufweisen.</assert>
      <assert test="(ram:CategoryTradeTax/ram:CategoryCode)">
	Jeder Nachlass für die Rechnung als Ganzes „DOCUMENT LEVEL ALLOWANCES“ (BG-20) muss einen Umsatzsteuer-Code „Document level allowance VAT category code“ (BT-95) aufweisen.</assert>
      <assert test="(ram:Reason) or (ram:ReasonCode)">
	Jeder Nachlass für die Rechnung als Ganzes „DOCUMENT LEVEL ALLOWANCES“ (BG-20) muss einen Nachlassgrund „Document level allowance reason“ (BT-97) oder einen entsprechenden Code „Document level allowance reason code“ (BT-98) aufweisen.</assert>
      <assert test="true()">
	Der Code des Grundes für den Nachlass auf der Dokumentenebene „Document level allowance reason code“ (BT-98) und der Grund für den Nachlass auf der Dokumentenebene „Document level allowance reason“ (BT-97) müssen dieselbe Nachlassart anzeigen.</assert>
      <assert test="(ram:Reason) or (ram:ReasonCode)">
	Jede Gruppe „DOCUMENT LEVEL ALLOWANCES“ (BG-20) muss entweder ein Element „Document level allowance reason“ (BT-97) oder ein Element „Document level allowance reason code“ (BT-98) oder beides enthalten.</assert>
      <assert test="string-length(substring-after(ram:ActualAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Document level allowance amount (BT-92) is 2.</assert>
      <assert test="string-length(substring-after(ram:BasisAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Document level allowance base amount (BT-93) is 2.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos;]">
      <assert test="(ram:ActualAmount)">
	Jede Abgabe auf Dokumentenebene „DOCUMENT LEVEL CHARGES“ (BG-21) muss einen Betrag „Document level charge amount“ (BT-99) aufweisen.</assert>
      <assert test="(ram:CategoryTradeTax/ram:CategoryCode)">
	Jede Abgabe auf Dokumentenebene „DOCUMENT LEVEL CHARGES“ (BG-21) muss einen Umsatzsteuer-Code „Document level charge VAT category code“ (BT-102) aufweisen.</assert>
      <assert test="(ram:Reason) or (ram:ReasonCode)">
	Jede Abgabe auf Dokumentenebene „DOCUMENT LEVEL CHARGES“ (BG-21) muss einen Abgabegrund „Document level charge reason“ (BT-104) oder einen entsprechenden Code „Document level charge reason code“ (BT-105) aufweisen.</assert>
      <assert test="true()">
	Der Code des Grundes für die Abgaben auf der Dokumentenebene „Document level charge reason code“ (BT-105) und der Grund für die Abgaben auf der Dokumentenebene „Document level charge reason“ (BT-104) müssen dieselbe Abgabenart anzeigen.</assert>
      <assert test="(ram:Reason) or (ram:ReasonCode)">
	Jede Gruppe „DOCUMENT LEVEL CHARGES“ (BG-21) muss entweder ein Element „Document level charge reason“ (BT-104) oder ein Element „Document level charge reason code“ (BT-105) oder beides enthalten.</assert>
      <assert test="string-length(substring-after(ram:ActualAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Document level charge amount (BT-92) is 2.</assert>
      <assert test="string-length(substring-after(ram:BasisAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Document level charge base amount (BT-93) is 2.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:ApplicableProductCharacteristic">
      <assert test="(ram:Description) and (ram:Value)">
	Jede Eigenschaft eines in Rechnung gestellten Postens „ITEM ATTRIBUTES“ (BG-32) muss eine Bezeichnung „Item attribute name“ (BT-160) und einen Wert „Item attribute value“ (BT-161) haben.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:ApplicableTradeSettlementFinancialCard">
      <assert test="string-length(ram:ID)&lt;=6 and string-length(ram:ID)&gt;=4">
	Die letzten vier bis sechs Ziffern der Kreditkartennummer „Payment card primary account number“ (BT-87) sollen angegeben werden, wenn Informationen zur Kartenzahlung übermittelt werden.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:IncludedSupplyChainTradeLineItem">
      <assert test="(ram:AssociatedDocumentLineDocument/ram:LineID!=&apos;&apos;)">
	Jede Rechnungsposition „INVOICE LINE“ (BG-25) muss eine eindeutige Bezeichnung „Invoice line identifier“ (BT-126) haben.</assert>
      <assert test="(ram:SpecifiedLineTradeDelivery/ram:BilledQuantity)">
	Jede Rechnungsposition „INVOICE LINE“ (BG-25) muss die Menge der in der betreffenden Position in Rechnung gestellten Waren oder Dienstleistungen als Einzelposten „Invoiced quantity“ (BT-129) enthalten.</assert>
      <assert test="(ram:SpecifiedLineTradeDelivery/ram:BilledQuantity/@unitCode)">
	Jede Rechnungsposition „INVOICE LINE“ (BG-25) muss eine Einheit zur Mengenangabe „Invoiced quantity unit of measure code“ (BT-130) enthalten.</assert>
      <assert test="(ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)">
	Jede Rechnungsposition „INVOICE LINE“ (BG-25) muss den Nettobetrag der Rechnungsposition „Invoice line net amount“ (BT-131) enthalten.</assert>
      <assert test="(ram:SpecifiedTradeProduct/ram:Name!=&apos;&apos;)">
	Jede Rechnungsposition „INVOICE LINE“ (BG-25) muss den Namen des Postens „Item name“ (BT-153) enthalten.</assert>
      <assert test="(ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:ChargeAmount)">
	Jede Rechnungsposition „INVOICE LINE“ (BG-25) muss den Preis des Postens, ohne Umsatzsteuer, nach Abzug des für diese Rechnungsposition geltenden Rabatts „Item net price“ (BT-146) beinhalten.</assert>
      <assert test="(ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:ChargeAmount) &gt;= 0">
	Der Artikel-Nettobetrag „Item net price“ (BT-146) darf nicht negativ sein.</assert>
      <assert test="(ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:ChargeAmount &gt;= 0) or not(ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:ChargeAmount)">
	Der Einheitspreis ohne Umsatzsteuer vor Abzug des Postenpreisrabatts einer Rechnungsposition „Item gross price“ (BT-148) darf nicht negativ sein.</assert>
      <assert test="ram:SpecifiedTradeProduct/ram:GlobalID/@schemeID!=&apos;&apos; or not (ram:SpecifiedTradeProduct/ram:GlobalID)">
	Im Element „Item standard identifier“ (BT-157) muss die Komponente „Scheme Identifier“ vorhanden sein.</assert>
      <assert test="(ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ClassCode/@listID!=&apos;&apos;) or not (ram:SpecifiedTradeProduct/ram:DesignatedProductClassification)">
	Im Element „Item classification identifier“ (BT-158) muss die Komponente „Scheme Identifier“ vorhanden sein.</assert>
      <assert test="(ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode)">
	Jede Rechnungsposition „INVOICE LINE“ (BG-25) muss anhand der Umsatzsteuerkategorie des in Rechnung gestellten Postens „Invoiced item VAT category code“ (BT-151) kategorisiert werden.</assert>
      <assert test="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax">
	Eine Rechnung (INVOICE) soll mindestens eine Gruppe „VAT BREAKDOWN“ (BG-23) enthalten.</assert>
      <assert test="string-length(substring-after(ram:SpecifiedTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Invoice line net amount (BT-131) is 2.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:PayeeTradeParty">
      <assert test="(ram:Name) and (not(ram:Name = ../ram:SellerTradeParty/ram:Name) and not(ram:ID = ../ram:SellerTradeParty/ram:ID) and not(ram:SpecifiedLegalOrganization/ram:ID = ../ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:ID))">
	Eine Rechnung (INVOICE) muss den Namen des Zahlungsempfängers „Payee name“ (BT-59) enthalten, wenn sich der Zahlungsempfänger „PAYEE“ (BG-10) vom Verkäufer „SELLER“ (BG-4) unterscheidet.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SellerTaxRepresentativeTradeParty">
      <assert test="(ram:Name)">
	Eine Rechnung (INVOICE) muss den Namen des Steuervertreters des Verkäufers „Seller tax representative name“ (BT-62) enthalten, wenn der Verkäufer „SELLER“ (BG-4) einen Steuervertreter hat.</assert>
      <assert test="(ram:PostalTradeAddress)">
	Eine Rechnung (INVOICE) muss die postalische Anschrift des Steuervertreters „SELLER TAX REPRESENTATIVE POSTAL ADDRESS“ (BG-12) enthalten, wenn der Verkäufer „SELLER“ (BG-4) einen Steuervertreter hat.</assert>
      <assert test="(ram:PostalTradeAddress/ram:CountryID)">
	Die postalische Anschrift des Steuervertreters des Verkäufers „SELLER TAX REPRESENTATIVE POSTAL ADDRESS“ (BG-12) muss einen Steuervertreter-Ländercode enthalten, wenn der Verkäufer „SELLER“ (BG-4) einen Steuervertreter hat.</assert>
      <assert test="(ram:SpecifiedTaxRegistration/ram:ID[@schemeID=&apos;VA&apos;]!=&apos;&apos;)">
	Jeder Steuervertreter des Verkäufers „SELLER TAX REPRESENTATIVE PARTY“ (BG-11) muss eine Umsatzsteuer-Identifikationsnummer „Seller tax representative VAT identifier“ (BT-63) haben.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SellerTradeParty">
      <assert test="(ram:ID) or (ram:GlobalID) or (ram:SpecifiedLegalOrganization/ram:ID) or (ram:SpecifiedTaxRegistration/ram:ID[@schemeID=&apos;VA&apos;])">
	Damit der Erwerber den Lieferanten automatisch identifizieren kann, soll der „Seller identifier“ (BT-29), der „Seller legal registration identifier“ (BT-30) oder der „Seller VAT identifier“ (BT-31) vorhanden sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod">
      <assert test="(ram:EndDateTime/udt:DateTimeString[@format = &apos;102&apos;]) &gt;= (ram:StartDateTime/udt:DateTimeString[@format = &apos;102&apos;]) or not (ram:EndDateTime) or not (ram:StartDateTime)">
	Wenn Start- und Enddatum des Rechnungspositionenzeitraums gegeben sind, muss das Enddatum „Invoice line period end date“ (BT-135) nach dem Startdatum „Invoice line period start date“ (BT-134) liegen oder mit diesem identisch sein.</assert>
      <assert test="(ram:StartDateTime) or (ram:EndDateTime)">
	Wenn die Gruppe „INVOICE LINE PERIOD“ (BG-26) verwendet wird, müssen entweder das Element „Invoice line period start date“ (BT-134) oder das Element „Invoice line period end date“ (BT-135) oder beide gefüllt sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator = &apos;false&apos;]">
      <assert test="(ram:ActualAmount)">
	Jeder Nachlass auf der Ebene der Rechnungsposition „INVOICE LINE ALLOWANCES“ (BG-27) muss einen Betrag „Invoice line allowance amount“ (BT-136) aufweisen.</assert>
      <assert test="(ram:Reason) or (ram:ReasonCode)">
	Jeder Nachlass auf der Ebene der Rechnungsposition „INVOICE LINE ALLOWANCES“ (BG-27) muss einen Nachlassgrund „Invoice line allowance reason“ (BT-139) oder einen entsprechenden Code „Invoice line allowance reason code“ (BT-140) aufweisen.</assert>
      <assert test="true()">
	Der Code für den Grund des Rechnungszeilennachlasses „Invoice line allowance reason code“ (BT-140) und der Grund für den Rechnungszeilennachlass „Invoice line allowance reason“ (BT-139) müssen dieselbe Nachlassart anzeigen.</assert>
      <assert test="(ram:Reason) or (ram:ReasonCode)">
	Jede Gruppe „INVOICE LINE ALLOWANCES“ (BG-27) muss entweder ein Element „Invoice line allowance reason“ (BT-139) oder ein Element „Invoice line allowance reason code“ (BT-140) oder beides enthalten.</assert>
      <assert test="string-length(substring-after(ram:ActualAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Invoice line allowance amount (BT-136) is 2.</assert>
      <assert test="string-length(substring-after(ram:BasisAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Invoice line allowance base amount (BT-137) is 2.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator = &apos;true&apos;]">
      <assert test="(ram:ActualAmount)">
	Jede Abgabe auf der Ebene der Rechnungsposition „INVOICE LINE CHARGES“ (BG-28) muss einen Betrag „Invoice line charge amount“ (BT-141) aufweisen.</assert>
      <assert test="(ram:Reason) or (ram:ReasonCode)">
	Jede Abgabe auf der Ebene der Rechnungsposition „INVOICE LINE CHARGES“ (BG-28) muss einen Abgabegrund „Invoice line charge reason“ (BT-144) oder einen entsprechenden Code „Invoice line charge reason code“ (BT-145) aufweisen.</assert>
      <assert test="true()">
	Der Code für den Grund der Abgabe auf Rechnungspositionsebene „Invoice line charge reason code“ (BT-145) und der Grund für die Abgabe auf Rechnungspositionsebene „Invoice line charge reason“ (BT-144) müssen dieselbe Abgabenart anzeigen.</assert>
      <assert test="(ram:Reason) or (ram:ReasonCode)">
	Jede Gruppe „INVOICE LINE CHARGES“ (BG-28) muss entweder ein Element „Invoice line charge reason“ (BT-144) oder ein Element „Invoice line charge reason code“ (BT-145) oder beides enthalten.</assert>
      <assert test="string-length(substring-after(ram:ActualAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Invoice line charge amount (BT-141) is 2.</assert>
      <assert test="string-length(substring-after(ram:BasisAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Invoice line charge base amount (BT-142) is 2.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTaxRegistration/ram:ID[@schemeID=&apos;VA&apos;]">
      <assert test="contains(&apos; EL AD AE AF AG AI AL AM AN AO AQ AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BL BJ BM BN BO BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN CO CR CU CV CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE IL IM IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO SR ST SV SY SZ TC TD TF TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA UG UM US UY UZ VA VC VE VG VI VN VU WF WS YE YT ZA ZM ZW &apos;, concat(&apos; &apos;, substring(.,1,2), &apos; &apos;))">
	Der Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), der Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) und der Umsatzsteuer-Identifikationsnummer des Erwerbers „Buyer VAT identifier“ (BT-48) muss zur Kennzeichnung des Mitgliedstaats, der sie erteilt hat, jeweils ein Präfix nach dem ISO-Code 3166 Alpha-2 vorangestellt werden. Griechenland wird jedoch ermächtigt, das Präfix „EL“ zu verwenden.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;AE&apos;]">
      <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]) and (//ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;] or //ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:ID)">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL ALLOWANCES“ (BG-20) enthält, in der „Document level allowance VAT category code“ (BT-95) den Wert „Exempt from VAT“ hat, müssen entweder „Seller VAT identifier“ (BT-31), „Seller tax registration identifier“ (BT-32) oder „Seller tax representative VAT identifier“ (BT-63) sowie die Umsatzsteuer-Identifikationsnummer des Erwerbers „Buyer VAT identifier“ (BT-48) oder „Buyer tax registration identifier“ vorhanden sein.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „DOCUMENT LEVEL ALLOWANCES“ (BG-20), in der „Document level allowance VAT category code“ (BT-95) den Wert „Reverse charge“ hat, muss „Document level allowance VAT rate“ (BT-96) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;E&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL ALLOWANCES“ (BG-20) enthält, in der „Document level allowance VAT category code“ (BT-95) den Wert „Exempt from VAT“ hat, muss entweder „Seller VAT identifier“ (BT-31), „Seller tax registration identifier“ (BT-32) oder „Seller tax representative VAT identifier“ (BT-63) vorhanden sein.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „DOCUMENT LEVEL ALLOWANCES“ (BG-20), in der „Document level allowance VAT category code“ (BT-95) den Wert „Exempt from VAT“ hat, muss „Document level allowance VAT rate“ (BT-96) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;G&apos;]">
      <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;])">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL ALLOWANCES“ (BG-20) enthält, in der „Document level allowance VAT category code“ (BT-95) den Wert „Export outside the EU“ hat, muss die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31) oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) enthalten sein.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „DOCUMENT LEVEL ALLOWANCES“ (BG-20), in der „Document level allowance VAT category code“ (BT-95) den Wert „Export outside the EU“ hat, muss „Document level allowance VAT rate“ (BT-96) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;K&apos;]">
      <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]) and //ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL ALLOWANCES“ (BG-20) enthält, in der „Document level allowance VAT category code“ (BT-95) den Wert „intra-community supply“ hat, müssen die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31) oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) sowie die Umsatzsteuer-Identifikationsnummer des Erwerbers „Buyer VAT identifier“ (BT-48) enthalten sein.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer Abgabe auf der Dokumentenebene, in dem als Code der Umsatzsteuerkategorie für den Rechnungsposten der Wert „IGIC“ angegeben ist, muss der Umsatzsteuersatz für den in Rechnung gestellten Posten „0“ oder größer „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;L&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	Eine Rechnung (INVOICE), die eine Abgabe auf der Dokumentenebene enthält, bei dem als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens der Wert „IGIC“ angegeben ist, muss die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), den Bezeichner der Steuerangaben des Verkäufers oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) enthalten.</assert>
      <assert test="ram:RateApplicablePercent &gt; 0">
	In einer Abgabe auf der Dokumentenebene, in dem als Code der Umsatzsteuerkategorie für den Rechnungsposten der Wert „IGIC“ angegeben ist, muss der Umsatzsteuersatz für den in Rechnung gestellten Posten „0“ oder größer „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;M&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	Eine Rechnung (INVOICE), die eine Abgabe auf der Dokumentenebene enthält, bei dem als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens der Wert „IPSI“ angegeben ist, muss die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), den Bezeichner der Steuerangaben des Verkäufers oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) enthalten.</assert>
      <assert test="ram:RateApplicablePercent &gt; 0">
	In einem Abgabe auf der Dokumentenebene, in dem als Code der Umsatzsteuerkategorie für den Rechnungsposten der Wert „IPSI“ angegeben ist, muss der Umsatzsteuersatz für den in Rechnung gestellten Posten „0“ oder größer „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;O&apos;]">
      <assert test="not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]) and not (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]) and not (/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;])">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL ALLOWANCES“ (BG-20) enthält, in der „Document level allowance VAT category code“ (BT-95) den Wert „Not subject to VAT“ hat, dürfen die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) sowie die Umsatzsteuer-Identifikationsnummer des Erwerbers „Buyer VAT identifier“ (BT-48) nicht enthalten sein.</assert>
      <assert test="not(ram:RateApplicablePercent)">
	In einer „DOCUMENT LEVEL ALLOWANCES“ (BG-20), in der „Document level allowance VAT category code“ (BT-95) den Wert „Not subject to VAT“ hat, darf „Document level allowance VAT rate“ (BT-96) nicht enthalten sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;S&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL ALLOWANCES“ (BG-20) enthält, in der „Document level allowance VAT category code“ (BT-95) den Wert „Standard rated“ hat, muss entweder „Seller VAT identifier“ (BT-31), „Seller tax registration identifier“ (BT-32) oder „Seller tax representative VAT identifier“ (BT-63) vorhanden sein.</assert>
      <assert test="ram:RateApplicablePercent &gt; 0">
	In einer „DOCUMENT LEVEL ALLOWANCES“ (BG-20), in der „Document level allowance VAT category code“ (BT-95) den Wert „Standard rated“ hat, muss „Document level allowance VAT rate“ (BT-96) größer als „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;Z&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL ALLOWANCES“ (BG-20) enthält, in der „Document level allowance VAT category code“ (BT-95) den Wert „Zero rated“ hat, muss entweder „Seller VAT identifier“ (BT-31), „Seller tax registration identifier“ (BT-32) oder „Seller tax representative VAT identifier“ (BT-63) vorhanden sein.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „DOCUMENT LEVEL ALLOWANCES“ (BG-20), in der „Document level allowance VAT category code“ (BT-95) den Wert „Zero rated“ hat, muss „Document level allowance VAT rate“ (BT-96) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;AE&apos;]">
      <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]) and (//ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;] or //ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:ID)">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL CHARGES“ (BG-21) enthält, in der „Document level charge VAT category code“ (BT-102) den Wert „Exempt from VAT“ hat, muss entweder „Seller VAT identifier“ (BT-31), „Seller tax registration identifier“ (BT-32) oder „Seller tax representative VAT identifier“ (BT-63) und die Umsatzsteuer-Identifikationsnummer des Erwerbers „Buyer VAT identifier“ (BT-48) vorhanden sein.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „DOCUMENT LEVEL CHARGES“ (BG-21), in der „Document level charge VAT category code“ (BT-102) den Wert „Reverse charge“ hat, muss „Document level charge VAT rate“ (BT-103) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;E&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL CHARGES“ (BG-21) enthält, in der „Document level charge VAT category code“ (BT-102) den Wert „Exempt from VAT“ hat, muss entweder „Seller VAT identifier“ (BT-31), „Seller tax registration identifier“ (BT-32) oder „Seller tax representative VAT identifier“ (BT-63) vorhanden sein.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „DOCUMENT LEVEL CHARGES“ (BG-21), in der „Document level charge VAT category code“ (BT-102) den Wert „Exempt from VAT“ hat, muss „Document level charge VAT rate“ (BT-103) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;G&apos;]">
      <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;])">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL CHARGES“ (BG-21) enthält, in der „Document level charge VAT category code“ (BT-102) den Wert „Export outside the EU“ hat, muss die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31) oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) enthalten sein.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „DOCUMENT LEVEL CHARGES“ (BG-21), in der „Document level charge VAT category code“ (BT-102) den Wert „Export outside the EU“ hat, muss „Document level charge VAT rate“ (BT-103) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;K&apos;]">
      <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]) and //ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL CHARGES“ (BG-21) enthält, in der „Document level charge VAT category code“ (BT-102) den Wert „intra-community supply“ hat, müssen die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31) oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) sowie die Umsatzsteuer-Identifikationsnummer des Erwerbers „Buyer VAT identifier“ (BT-48) enthalten sein.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „DOCUMENT LEVEL CHARGES“ (BG-21), in der „Document level charge VAT category code“ (BT-102) den Wert „intra-community supply“ hat, muss „Document level charge VAT rate“ (BT-103) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;L&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	Eine Rechnung (INVOICE), die einen Nachlass auf der Dokumentenebene enthält, bei dem als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens der Wert „IGIC“ angegeben ist, muss die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), den Bezeichner der Steuerangaben des Verkäufers oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) enthalten.</assert>
      <assert test="ram:RateApplicablePercent &gt; 0">
	In einem Nachlass auf der Dokumentenebene, in dem als Code der Umsatzsteuerkategorie für den Rechnungsposten der Wert „IGIC“ angegeben ist, muss der Umsatzsteuersatz für den in Rechnung gestellten Posten „0“ oder größer „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;M&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	Eine Rechnung (INVOICE), die einen Nachlass auf der Dokumentenebene enthält, bei dem als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens der Wert „IPSI“ angegeben ist, muss die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), den Bezeichner der Steuerangaben des Verkäufers oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) enthalten.</assert>
      <assert test="ram:RateApplicablePercent &gt; 0">
	In einem Nachlass auf der Dokumentenebene, in dem als Code der Umsatzsteuerkategorie für den Rechnungsposten der Wert „IPSI“ angegeben ist, muss der Umsatzsteuersatz für den in Rechnung gestellten Posten „0“ oder größer „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;O&apos;]">
      <assert test="not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]) and not (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]) and not (/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;])">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL CHARGES“ (BG-21) enthält, in der „Document level charge VAT category code“ (BT-102) den Wert „Not subject to VAT“ hat, dürfen die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) sowie die Umsatzsteuer-Identifikationsnummer des Erwerbers „Buyer VAT identifier“ (BT-48) nicht enthalten sein.</assert>
      <assert test="not(ram:RateApplicablePercent)">
	In einer „DOCUMENT LEVEL CHARGES“ (BG-21), in der „Document level charge VAT category code“ (BT-102) den Wert „Not subject to VAT“ hat, darf „Document level charge VAT rate“ (BT-103) nicht enthalten sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;S&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL CHARGES“ (BG-21) enthält, in der „Document level charge VAT category code“ (BT-102) den Wert „Standard rated“ hat, muss entweder „Seller VAT identifier“ (BT-31), „Seller tax registration identifier“ (BT-32) oder „Seller tax representative VAT identifier“ (BT-63) vorhanden sein.</assert>
      <assert test="ram:RateApplicablePercent &gt; 0">
	In einer „DOCUMENT LEVEL CHARGES“ (BG-21), in der „Document level charge VAT category code“ (BT-102) den Wert „Standard rated“ hat, muss „Document level charge VAT rate“ (BT-103) größer als „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos;]/ram:CategoryTradeTax[ram:CategoryCode = &apos;Z&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	In einer Rechnung, die eine Gruppe „DOCUMENT LEVEL CHARGES“ (BG-21) enthält, in der „Document level charge VAT category code“ (BT-102) den Wert „Zero rated“ hat, muss entweder „Seller VAT identifier“ (BT-31), „Seller tax registration identifier“ (BT-32) oder „Seller tax representative VAT identifier“ (BT-63) vorhanden sein.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „DOCUMENT LEVEL CHARGES“ (BG-21), in der „Document level charge VAT category code“ (BT-102) den Wert „Zero rated“ hat, muss „Document level charge VAT rate“ (BT-103) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeSettlementHeaderMonetarySummation">
      <assert test="(ram:LineTotalAmount)">
	Eine Rechnung (INVOICE) muss die Summe der Rechnungspositionen-Nettobeträge „Sum of Invoice line net amount“ (BT-106) enthalten.</assert>
      <assert test="(ram:TaxBasisTotalAmount)">
	Eine Rechnung (INVOICE) muss den Gesamtbetrag der Rechnung ohne Umsatzsteuer „Invoice total amount without VAT“ (BT-109) enthalten.</assert>
      <assert test="(ram:GrandTotalAmount)">
	Eine Rechnung (INVOICE) muss den Gesamtbetrag der Rechnung mit Umsatzsteuer „Invoice total amount with VAT“ (BT-112) enthalten.</assert>
      <assert test="(ram:DuePayableAmount)">
	Eine Rechnung (INVOICE) muss den ausstehenden Betrag „Amount due for payment“ (BT-115) enthalten.</assert>
      <assert test="(not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos;])and not (ram:AllowanceTotalAmount)) or ram:AllowanceTotalAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos;]/ram:ActualAmount)* 10 * 10 ) div 100)">
	Der Inhalt des Elementes „Sum of allowances on document level“ (BT-107) entspricht der Summe aller Inhalte der Elemente „Document level allowance amount“ (BT-92).</assert>
      <assert test="(not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos;])and not (ram:ChargeTotalAmount)) or ram:ChargeTotalAmount = &#13;&#10;((round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos;]/ram:ActualAmount)* 10 * 10 ) div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedLogisticsServiceCharge/ram:AppliedAmount)* 10 * 10 ) div 100))">
	Der Inhalt des Elementes „Sum of charges on document level“ (BT-108) entspricht der Summe aller Inhalte der Elemente „Document level charge amount“ (BT-99).</assert>
      <assert test="(ram:TaxBasisTotalAmount = ram:LineTotalAmount - ram:AllowanceTotalAmount + ram:ChargeTotalAmount) or ((ram:TaxBasisTotalAmount = ram:LineTotalAmount - ram:AllowanceTotalAmount) and not (ram:ChargeTotalAmount)) or     ((ram:TaxBasisTotalAmount = ram:LineTotalAmount + ram:ChargeTotalAmount) and not (ram:AllowanceTotalAmount)) or ((ram:TaxBasisTotalAmount = ram:LineTotalAmount) and not (ram:ChargeTotalAmount) and not (ram:AllowanceTotalAmount))">
	Der Inhalt des Elementes „Invoice total amount without VAT“ (BT-109) entspricht der Summe aller Inhalte der Elemente „Invoice line net amount“ (BT-131) abzüglich der Summe aller in der Rechnung enthaltenen Nachlässe der Dokumentenebene „Sum of allowances on document level“ (BT-107) zuzüglich der Summe aller in der Rechnung enthaltenen Abgaben der Dokumentenebene „Sum of charges on document level“ (BT-108).</assert>
      <assert test="(ram:GrandTotalAmount = round(ram:TaxBasisTotalAmount*100 + ram:TaxTotalAmount[@currencyID=/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode]*100 +0) div 100) or ((ram:GrandTotalAmount = ram:TaxBasisTotalAmount) and not (ram:TaxTotalAmount[@currencyID=/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode]))">
	Der Inhalt des Elementes „Invoice total amount with VAT“ (BT-112) entspricht der Summe des Inhalts des Elementes „Invoice total amount without VAT“ (BT-109) und des Elementes „Invoice total VAT amount“ (BT-110).</assert>
      <assert test="(ram:DuePayableAmount = round (ram:GrandTotalAmount*100 - ram:TotalPrepaidAmount*100 + ram:RoundingAmount*100) div 100)&#13;&#10;or ((ram:DuePayableAmount = round (ram:GrandTotalAmount*100 + ram:RoundingAmount*100) div 100) and not (ram:TotalPrepaidAmount)) &#13;&#10;or ((ram:DuePayableAmount = round (ram:GrandTotalAmount*100 - ram:TotalPrepaidAmount*100) div 100) and not (ram:RoundingAmount)) &#13;&#10;or ((ram:DuePayableAmount = round (ram:GrandTotalAmount*100) div 100) and not (ram:TotalPrepaidAmount) and not (ram:RoundingAmount))">
	Der Inhalt des Elementes „Amount due for payment“ (BT-115) entspricht dem Inhalt des Elementes „Invoice total VAT amount“ (BT-110) abzüglich dem Inhalt des Elementes „Paid amount“ (BT-113) zuzüglich dem Inhalt des Elementes „Rounding amount“ (BT-114).</assert>
      <assert test="string-length(substring-after(ram:LineTotalAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Sum of Invoice line net amount (BT-106) is 2.</assert>
      <assert test="string-length(substring-after(ram:AllowanceTotalAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Sum of allowanced on document level (BT-107) is 2.</assert>
      <assert test="string-length(substring-after(ram:ChargeTotalAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Sum of charges on document level (BT-108) is 2.</assert>
      <assert test="string-length(substring-after(ram:TaxBasisTotalAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Invoice total amount without VAT (BT-109) is 2.</assert>
      <assert test="not(ram:TaxTotalAmount) or ram:TaxTotalAmount[(@currencyID =/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode and . = round(. * 100) div 100) or not (@currencyID =/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode)]">
	The allowed maximum number of decimals for the Invoice total VAT amount (BT-110) is 2.</assert>
      <assert test="string-length(substring-after(ram:GrandTotalAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Invoice total amount with VAT (BT-112) is 2.</assert>
      <assert test="not(ram:TaxTotalAmount) or ram:TaxTotalAmount[(@currencyID =/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode and . = round(. * 100) div 100) or not (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode)]">
	The allowed maximum number of decimals for the Invoice total VAT amount in accounting currency (BT-111) is 2.</assert>
      <assert test="string-length(substring-after(ram:TotalPrepaidAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Paid amount (BT-113) is 2.</assert>
      <assert test="string-length(substring-after(ram:RoundingAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Rounding amount (BT-114) is 2.</assert>
      <assert test="string-length(substring-after(ram:DuePayableAmount,&apos;.&apos;))&lt;=2">
	The allowed maximum number of decimals for the Amount due for payment (BT-115) is 2.</assert>
      <assert test="not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode) or (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode and (ram:TaxTotalAmount/@currencyID = /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode) and not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode = /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode))">
	Wenn eine Währung für die Umsatzsteuerabrechnung angegeben wurde, muss der Umsatzsteuergesamtbetrag in der Abrechnungswährung „Invoice total VAT amount in accounting currency“ (BT-111) angegeben werden.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeSettlementPaymentMeans">
      <assert test="(ram:TypeCode)">
	Die Zahlungsinstruktionen „PAYMENT INSTRUCTIONS“ (BG-16) müssen den Zahlungsart-Code „Payment means type code“ (BT-81) enthalten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//ram:SpecifiedTradeSettlementPaymentMeans[ram:TypeCode=&apos;30&apos; or ram:TypeCode=&apos;58&apos;]/ram:PayerPartyDebtorFinancialAccount">
      <assert test="(ram:IBANID) or (ram:ProprietaryID)">
	Die Kennung des Kontos, auf das die Zahlung erfolgen soll „Payment account identifier“ (BT-84), muss angegeben werden, wenn Überweisungsinformationen in der Rechnung angegeben werden.</assert>
      <assert test="(ram:IBANID) or (ram:ProprietaryID)">
	Wenn der Zahlungsmittel-Typ SEPA, lokale Überweisung oder Nicht-SEPA-Überweisung ist, muss der „Payment account identifier“ (BT-84) des Zahlungsempfängers angegeben werden.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[. = &apos;AE&apos;]">
      <assert test="../ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = &apos;AE&apos;]/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;AE&apos;]/ram:ActualAmount)*10*10)div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;AE&apos;]/ram:ActualAmount)*10*10)div 100)">
	In einer „VAT BREAKDOWN“ (BG-23), in der als Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) der Wert „Reverse charge“ angegeben ist, muss der „VAT category taxable amount“ (BT-116) gleich der Summe der „Invoice line net amount“ (BT-131) abzüglich der „Document level allowance amount“ (BT-92) zuzüglich der „Document level charge amount“ (BT-99) sein, wobei als „Invoiced item VAT category code“ (BT-151), als „Document level allowance VAT category code“ (BT-95) sowie als „Document level charge VAT category code“ (BT-102) jeweils der Wert „Reverse charge“ angegeben wird.</assert>
      <assert test="../ram:CalculatedAmount = 0">
	Der „VAT category tax amount“ (BT-117) muss in einer „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „Reverse charge“ gleich „0“ sein.</assert>
      <assert test="(../ram:ExemptionReason) or (../ram:ExemptionReasonCode)">
	Ein „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „Reverse charge“ muss einen „VAT exemption reason code“ (BT-121) mit dem Wert „Reverse charge“ oder einen „VAT exemption reason text“ (BT-120) des Wertes „Reverse charge“ (oder das Äquivalent in einer anderen Sprache) enthalten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[. = &apos;E&apos;]">
      <assert test="../ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = &apos;E&apos;]/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;E&apos;]/ram:ActualAmount)*10*10)div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;E&apos;]/ram:ActualAmount)*10*10)div 100)">
	In einer „VAT BREAKDOWN“ (BG-23), in der als Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) der Wert „Exempt from VAT“ angegeben ist, muss der „VAT category taxable amount“ (BT-116) gleich der Summe der „Invoice line net amount“ (BT-131) abzüglich der „Document level allowance amount“ (BT-92) zuzüglich der „Document level charge amount“ (BT-99) sein, wobei als „Invoiced item VAT category code“ (BT-151), als „Document level allowance VAT category code“ (BT-95) sowie als „Document level charge VAT category code“ (BT-102) jeweils der Wert „Exempt from VAT“ angegeben wird.</assert>
      <assert test="../ram:CalculatedAmount = 0">
	Der „VAT category tax amount“ (BT-117) muss in einer „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) dem Wert „Exempt from VAT“ gleich „0“ sein.</assert>
      <assert test="(../ram:ExemptionReason) or (../ram:ExemptionReasonCode)">
	Ein „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „Exempt from VAT“ muss einen Code des Umsatzsteuerbefreiungsgrundes „VAT exemption reason code“ (BT-121) oder einen Text des Umsatzsteuerbefreiungsgrundes „VAT exemption reason text“ (BT-120) enthalten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[. = &apos;G&apos;]">
      <assert test="../ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = &apos;G&apos;]/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;G&apos;]/ram:ActualAmount)*10*10)div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;G&apos;]/ram:ActualAmount)*10*10)div 100)">
	In einer „VAT BREAKDOWN“ (BG-23), in der als Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) der Wert „Export outside the EU“ angegeben ist, muss der „VAT category taxable amount“ (BT-116) gleich der Summe der „Invoice line net amount“ (BT-131) abzüglich der „Document level allowance amount“ (BT-92) zuzüglich der „Document level charge amount“ (BT-99) sein, wobei als „Invoiced item VAT category code“ (BT-151), als „Document level allowance VAT category code“ (BT-95) sowie als „Document level charge VAT category code“ (BT-102) jeweils der Wert „Export outside the EU“ angegeben wird.</assert>
      <assert test="../ram:CalculatedAmount = 0">
	Der „VAT category tax amount“ (BT-117) muss in „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „Export outside the EU“ gleich „0“ sein.</assert>
      <assert test="(../ram:ExemptionReason) or (../ram:ExemptionReasonCode)">
	Ein „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „intra-community supply“ muss einen „VAT exemption reason code“ (BT-121) mit dem Wert „Export outside the EU“ oder einen „VAT exemption reason text“ (BT-120) des Wertes „Export outside the EU“ (oder das Äquivalent in einer anderen Sprache) enthalten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[.= &apos;K&apos;]">
      <assert test="../ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = &apos;K&apos;]/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;K&apos;]/ram:ActualAmount)*10*10)div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;K&apos;]/ram:ActualAmount)*10*10)div 100)">
	In einer „VAT BREAKDOWN“ (BG-23), in der als Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) der Wert „intra-community supply“ angegeben ist, muss der „VAT category taxable amount“ (BT-116) gleich der Summe der „Invoice line net amount“ (BT-131) abzüglich der „Document level allowance amount“ (BT-92) zuzüglich der „Document level charge amount“ (BT-99) sein, wobei als „Invoiced item VAT category code“ (BT-151), als „Document level allowance VAT category code“ (BT-95) sowie als „Document level charge VAT category code“ (BT-102) jeweils der Wert „intra-community supply“ angegeben wird.</assert>
      <assert test="../ram:CalculatedAmount = 0">
	Der in der Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) angegebene Betrag der nach Kategorie zu entrichtenden Umsatzsteuer, bei dem als Code der Umsatzsteuerkategorie der Wert „IGIC“ angegeben ist, muss gleich dem mit dem kategoriespezifischen Umsatzsteuersatz multiplizierten nach der Umsatzsteuerkategorie zu versteuernden Betrag sein.</assert>
      <assert test="(../ram:ExemptionReason) or (../ram:ExemptionReasonCode)">
	Ein „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „intra-community supply“ muss einen „VAT exemption reason code“ (BT-121) mit dem Wert „intra-community supply“ oder einen „VAT exemption reason text“ (BT-120) mit dem Wert „intracommunity supply“ (oder das Äquivalent in einer anderen Sprache) enthalten.</assert>
      <assert test="(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:OccurrenceDateTime/udt:DateTimeString) or (../../ram:BillingSpecifiedPeriod/ram:StartDateTime) or (../../ram:BillingSpecifiedPeriod/ram:EndDateTime)">
	In einer Rechnung, die ein „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „intra-community supply“ enthält, dürfen „Actual delivery date“ (BT-72) oder „INVOICING PERIOD“ (BG-14) nicht leer sein.</assert>
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CountryID">
	In einer Rechnung, die ein „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „intra-community supply“ enthält, darf „Deliver to country code“ (BT-80) nicht leer sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = &apos;L&apos;]">
      <assert test="ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = &apos;L&apos; and ram:RateApplicablePercent=ram:ApplicableTradeTax/ram:RateApplicablePercent]/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;L&apos; and ram:RateApplicablePercent=ram:CategoryTradeTax/ram:RateApplicablePercent]/ram:ActualAmount)*10*10) div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;L&apos; and ram:RateApplicablePercent=ram:CategoryTradeTax/ram:RateApplicablePercent]/ram:ActualAmount)*10*10) div 100)">
	Für jeden anderen Wert des kategoriespezifischen Umsatzsteuersatzes, bei dem als Code der Umsatzsteuerkategorie der Wert „IGIC“ angegeben ist, muss der nach der Umsatzsteuerkategorie zu versteuernde Betrag in einer Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) gleich der Summe der Rechnungspositions-Nettobeträge zuzüglich der Summe der Beträge aller Abschläge auf der Dokumentenebene abzüglich der Summe der Beträge aller Zuschläge auf der Dokumentenebene sein; wobei als Code der Umsatzsteuerkategorie der Wert „IGIC“ angegeben wird und der Umsatzsteuersatz gleich dem kategoriespezifischen Umsatzsteuersatz ist.</assert>
      <assert test="true()">
	Der in der Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) angegebene Betrag der nach Kategorie zu entrichtenden Umsatzsteuer, bei dem als Code der Umsatzsteuerkategorie der Wert „IGIC“ angegeben ist, muss gleich dem mit dem kategoriespezifischen Umsatzsteuersatz multiplizierten nach der Umsatzsteuerkategorie zu versteuernden Betrag sein.</assert>
      <assert test="not(ram:ExemptionReason) and not (ram:ExemptionReasonCode)">
	Eine Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie der Wert „IGIC“ darf keinen Code für den Umsatzsteuerbefreiungsgrund oder Text für den Umsatzsteuerbefreiungsgrund
haben.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = &apos;M&apos;]">
      <assert test="ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = &apos;M&apos; and ram:RateApplicablePercent=ram:ApplicableTradeTax/ram:RateApplicablePercent]/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;M&apos; and ram:RateApplicablePercent=ram:CategoryTradeTax/ram:RateApplicablePercent]/ram:ActualAmount)*10*10) div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;M&apos; and ram:RateApplicablePercent=ram:CategoryTradeTax/ram:RateApplicablePercent]/ram:ActualAmount)*10*10) div 100)">
	Für jeden anderen Wert des kategoriespezifischen Umsatzsteuersatzes, bei dem als Code der Umsatzsteuerkategorie der Wert „IPSI“ angegeben ist, muss der nach der Umsatzsteuerkategorie zu versteuernde Betrag in einer Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) gleich der Summe der Rechnungspositions-Nettobeträge zuzüglich der Summe der Beträge aller Abschläge auf der Dokumentenebene  abzüglich der Summe der Beträge aller Zuschläge auf der Dokumentenebene sein; wobei als Code der Umsatzsteuerkategorie der Wert „IPSI“ angegeben wird und der Umsatzsteuersatz gleich dem kategoriespezifischen Umsatzsteuersatz ist.</assert>
      <assert test="true()">
	Der in der Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) angegebene Betrag der nach Kategorie zu entrichtenden Umsatzsteuer, bei dem als Code der Umsatzsteuerkategorie der Wert „IPSI“ angegeben ist, muss gleich dem mit dem kategoriespezifischen Umsatzsteuersatz multiplizierten nach der Umsatzsteuerkategorie zu versteuernden Betrag sein.</assert>
      <assert test="not(ram:ExemptionReason) and not (ram:ExemptionReasonCode)">
	Eine Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie mit dem Wert „IPSI“ darf keinen Code für den Umsatzsteuerbefreiungsgrund oder Text für den Umsatzsteuerbefreiungsgrund haben.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = &apos;O&apos;]">
      <assert test="ram:BasisAmount = (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement[ram:ApplicableTradeTax/ram:CategoryCode = &apos;O&apos; and ram:RateApplicablePercent=ram:ApplicableTradeTax/ram:RateApplicablePercent]/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount)*10*10)div 100) + (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;true&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;O&apos; and ram:RateApplicablePercent=ram:CategoryTradeTax/ram:RateApplicablePercent]/ram:ActualAmount)*10*10)div 100) - (round(sum(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge[ram:ChargeIndicator/udt:Indicator=&apos;false&apos; and ram:CategoryTradeTax/ram:CategoryCode=&apos;O&apos;]/ram:ActualAmount)*10*10)div 100)">
	In einer „VAT BREAKDOWN“ (BG-23), in der als Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) der Wert „Not subject to VAT“ angegeben ist, muss der „VAT category taxable amount“ (BT-116) gleich der Summe der „Invoice line net amount“ (BT-131) abzüglich der „Document level allowance amount“ (BT-92) zuzüglich der „Document level charge amount“ (BT-99) sein, wobei als „Invoiced item VAT category code“ (BT-151), als „Document level allowance VAT category code“ (BT-95) sowie als „Document level charge VAT category code“ (BT-102) jeweils der Wert „Not subject to VAT“ angegeben wird.</assert>
      <assert test="ram:CalculatedAmount = 0">
	Der „VAT category tax amount“ (BT-117) muss in „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „Not subject to VAT“ gleich „0“ sein.</assert>
      <assert test="(ram:ExemptionReason) or (ram:ExemptionReasonCode)">
	Ein „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „Not subject to VAT“ muss einen „VAT exemption reason code“ (BT-121) mit dem Wert „Not subject to VAT“ oder einen „VAT exemption reason text“ (BT-120) des Wertes „Not subject to VAT“ (oder das Äquivalent in einer anderen Sprache) enthalten.</assert>
      <assert test="not(//ram:ApplicableTradeTax[ram:CategoryCode != &apos;O&apos;])">
	Eine Rechnung (INVOICE), die ein „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) den Wert „Not subject to VAT“ enthält, darf keine weiteren „VAT BREAKDOWN“ (BG-23) enthalten.</assert>
      <assert test="not(//ram:ApplicableTradeTax[ram:CategoryCode != &apos;O&apos;])">
	Eine Rechnung (INVOICE), die ein „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) den Wert „Not subject to VAT“ enthält, darf keine Positionen enthalten, deren „Invoiced item VAT category code“ (BT-151) einen anderen Wert als „Not subject to VAT“ hat.</assert>
      <assert test="not(//ram:CategoryTradeTax[ram:CategoryCode != &apos;O&apos;])">
	Eine Rechnung (INVOICE), die ein „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) den Wert „Not subject to VAT“ enthält, darf keine „DOCUMENT LEVEL ALLOWANCES“ (BG-20) enthalten, deren „Document level allowance VAT category code“ (BT-95) einen anderen Wert als „Not subject to VAT“ hat.</assert>
      <assert test="not(//ram:CategoryTradeTax[ram:CategoryCode != &apos;O&apos;])">
	Eine Rechnung (INVOICE), die ein „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „Not subject to VAT“ enthält, darf keine „DOCUMENT LEVEL CHARGES“ (BG-21) enthalten, deren „Document level charge VAT category code“ (BT-102) einen anderen Wert als „Not subject to VAT“ hat.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = &apos;AE&apos;]">
      <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]) and (//ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;] or //ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:ID)">
	Eine Rechnung (INVOICE), die eine Position enthält, in der als Code der Umsatzsteuerkategorie für den in Rechnung gestellten Posten „Invoiced item VAT category code“ (BT-151) der Wert „Exempt from VAT“ angegeben ist, muss die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), die Steueridentifikationsnummer des Verkäufers „Seller tax registration identifier“ (BT-32) oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) und die Umsatzsteuer-Identifikationsnummer des Erwerbers „Buyer VAT identifier“ (BT-48) oder den „Buyer tax registration identifier“a enthalten.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „INVOICE LINE“ (BG-25), in der „Invoiced item VAT category code“ (BT-151) den Wert „Reverse charge“ hat, muss „Invoiced item VAT rate“ (BT-152) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = &apos;E&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	Eine Rechnung (INVOICE), die eine Position enthält, in der als Code der Umsatzsteuerkategorie für den in Rechnung gestellten Posten „Invoiced item VAT category code“ (BT-151) der Wert „Exempt from VAT“ angegeben ist, muss die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), die Steueridentifikationsnummer des Verkäufers „Seller tax registration identifier“ (BT-32) oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) enthalten.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „INVOICE LINE“ (BG-25), in der „Invoiced item VAT category code“ (BT-151) den Wert „Exempt from VAT“ hat, muss „Invoiced item VAT rate“ (BT-152) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = &apos;G&apos;]">
      <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;])">
	Eine Rechnung (INVOICE), die eine Position enthält, in der als Code der Umsatzsteuerkategorie für den in Rechnung gestellten Posten „Invoiced item VAT category code“ (BT-151) der Wert „Export outside the EU“ angegeben ist, muss die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31) oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) enthalten.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „INVOICE LINE“ (BG-25), in der „Invoiced item VAT category code“ (BT-151) den Wert „Export outside the EU“ hat, muss „Invoiced item VAT rate“ (BT-152) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = &apos;K&apos;]">
      <assert test="(//ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;] or //ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]) and //ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	Eine Rechnung (INVOICE), die eine Position enthält, in der als Code der Umsatzsteuerkategorie für den in Rechnung gestellten Posten „Invoiced item VAT category code“ (BT-151) der Wert „intra-community supply“ angegeben ist, müssen die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31) oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) sowie die Umsatzsteuer-Identifikationsnummer des Erwerbers „Buyer VAT identifier“ (BT-48) enthalten.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „INVOICE LINE“ (BG-25), in der „Invoiced item VAT category code“ (BT-151) den Wert „intracommunity supply“ hat, muss „Invoiced item VAT rate“ (BT-152) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = &apos;L&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	Eine Rechnung (INVOICE), die eine Position enthält, bei der als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens der Wert „IGIC“ angegeben ist, muss die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), den Bezeichner der Steuerangaben des Verkäufers oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) enthalten.</assert>
      <assert test="ram:RateApplicablePercent &gt; 0">
	In einer Rechnungsposition, in der als Code der Umsatzsteuerkategorie für den Rechnungsposten der Wert „IGIC“ angegeben ist, muss der Umsatzsteuersatz für den in Rechnung gestellten Posten „0“ oder größer „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = &apos;M&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	Eine Rechnung (INVOICE), die eine Position enthält, bei der als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens der Wert „IPSI“ angegeben ist, muss die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), den Bezeichner der Steuerangaben des Verkäufers oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) enthalten.</assert>
      <assert test="ram:RateApplicablePercent &gt; 0">
	In einer Rechnungsposition, in der als Code der Umsatzsteuerkategorie für den Rechnungsposten der Wert „IPSI“ angegeben ist, muss der Umsatzsteuersatz für den in Rechnung gestellten Posten „0“ oder größer „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = &apos;O&apos;]">
      <assert test="not(/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]) and not (/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]) and not (/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;])">
	Eine Rechnung (INVOICE), die eine Position enthält, in der als Code der Umsatzsteuerkategorie für den in Rechnung gestellten Posten der Wert „Not subject to VAT“ angegeben ist, darf keine Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) und die Umsatzsteuer-Identifikationsnummer des Erwerbers „Buyer VAT identifier“ (BT-48) enthalten.</assert>
      <assert test="not(ram:RateApplicablePercent)">
	In einer „INVOICE LINE“ (BG-25), in der „Invoiced item VAT category code“ (BT-151) den Wert „Not subject to VAT“ hat, darf „Invoiced item VAT rate“ (BT-152) nicht enthalten sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = &apos;S&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	Eine Rechnung (INVOICE), die eine Position enthält, in der als Code der Umsatzsteuerkategorie für den in Rechnung gestellten Posten „Invoiced item VAT category code“ (BT-151) der Wert „Standard rated“ angegeben ist, muss die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), die Steueridentifikationsnummer des Verkäufers „Seller tax registration identifier“ (BT-32) oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) enthalten.</assert>
      <assert test="ram:RateApplicablePercent &gt; 0">
	In einer „INVOICE LINE“ (BG-25), in der „Invoiced item VAT category code“ (BT-151) den Wert „Standard rated“ hat, muss „Invoiced item VAT rate“ (BT-152) größer als „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="//rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode = &apos;Z&apos;]">
      <assert test="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos; or @schemeID = &apos;FC&apos;] or /rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID = &apos;VA&apos;]">
	Eine Rechnung (INVOICE), die eine Position enthält, in der als Code der Umsatzsteuerkategorie für den in Rechnung gestellten Posten „Invoiced item VAT category code“ (BT-151) der Wert „Zero rated“ angegeben ist, muss die Umsatzsteuer-Identifikationsnummer des Verkäufers „Seller VAT identifier“ (BT-31), die Steueridentifikationsnummer des Verkäufers „Seller tax registration identifier“ (BT-32) oder die Umsatzsteuer-Identifikationsnummer des Steuervertreters des Verkäufers „Seller tax representative VAT identifier“ (BT-63) enthalten.</assert>
      <assert test="ram:RateApplicablePercent = 0">
	In einer „INVOICE LINE“ (BG-25), in der „Invoiced item VAT category code“ (BT-151) den Wert „Zero rated“ hat, muss „Invoiced item VAT rate“ (BT-152) gleich „0“ sein.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice">
      <assert test="(rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter/ram:ID != &apos;&apos;)">
	Eine Rechnung (INVOICE) muss eine Spezifikationskennung „Specification identification“ (BT-24) enthalten.</assert>
      <assert test="(rsm:ExchangedDocument/ram:ID !=&apos;&apos;)">
	Eine Rechnung (INVOICE) muss eine Rechnungsnummer „Invoice number“ (BT-1) enthalten.</assert>
      <assert test="(rsm:ExchangedDocument/ram:IssueDateTime/udt:DateTimeString[@format=&apos;102&apos;]!=&apos;&apos;)">
	Eine Rechnung (INVOICE) muss ein Rechnungsdatum „Invoice issue date“ (BT-2) enthalten.</assert>
      <assert test="(rsm:ExchangedDocument/ram:TypeCode!=&apos;&apos;)">
	Eine Rechnung (INVOICE) muss einen Rechnungstyp-Code „Invoice type code“ (BT-3) enthalten.</assert>
      <assert test="(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode!=&apos;&apos;)">
	Eine Rechnung (INVOICE) muss einen Währungs-Code „Invoice currency code“ (BT-5) enthalten.</assert>
      <assert test="(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:Name!=&apos;&apos;)">
	Eine Rechnung (INVOICE) muss den Verkäufernamen „Seller name“ (BT-27) enthalten.</assert>
      <assert test="(rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:Name!=&apos;&apos;)">
	Eine Rechnung (INVOICE) muss den Erwerbernamen „Buyer name“ (BT-44) enthalten.</assert>
      <assert test="//ram:SellerTradeParty/ram:PostalTradeAddress">
	Eine Rechnung (INVOICE) muss die postalische Anschrift des Verkäufers „SELLER POSTAL ADDRESS“ (BG-5) enthalten.</assert>
      <assert test="//ram:SellerTradeParty/ram:PostalTradeAddress/ram:CountryID!=&apos;&apos;">
	Eine postalische Anschrift des Verkäufers „SELLER POSTAL ADDRESS“ (BG-5) muss einen Verkäufer-Ländercode „Seller country code“ (BT-40) enthalten.</assert>
      <assert test="//ram:BuyerTradeParty/ram:PostalTradeAddress">
	Eine Rechnung (INVOICE) muss die postalische Anschrift des Erwerbers „BUYER POSTAL ADDRESS“ (BG-8) enthalten.</assert>
      <assert test="//ram:BuyerTradeParty/ram:PostalTradeAddress/ram:CountryID!=&apos;&apos;">
	Eine postalische Anschrift des Erwerbers „BUYER POSTAL ADDRESS“ (BG-8) muss einen Erwerber-Ländercode „Buyer country code“ (BT-55) enthalten.</assert>
      <assert test="rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication/ram:URIID/@schemeID!=&apos;&apos; or not (rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication)">
	Im Element „Seller electronic address“ (BT-34) muss die Komponente „Scheme Identifier“ vorhanden sein.</assert>
      <assert test="rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:URIID/@schemeID!=&apos;&apos; or not (rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication)">
	Im Element „Buyer electronic address“ (BT-49) muss die Komponente „Scheme Identifier“ vorhanden sein.</assert>
      <assert test="((count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;S&apos;]) + count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;S&apos;])) &gt;=2 or not (//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;S&apos;])) and     ((count(//ram:CategoryTradeTax[ram:CategoryCode=&apos;S&apos;]) + count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;S&apos;])) &gt;=2 or not (//ram:CategoryTradeTax[ram:CategoryCode=&apos;S&apos;]))">
	Eine Rechnung (INVOICE), die eine Position, einen Nachlass oder eine Abgabe auf Rechnungsebene enthält, in der als Code der für den in Rechnung gestellten Posten geltenden Umsatzsteuerkategorie „Invoiced item VAT category code“ (BT-151), als Code für das Umsatzsteuermerkmal, das auf den Nachlass auf Dokumentenebene anzuwenden ist „Document level allowance VAT category code“ (BT-95) oder als Code für das Umsatzsteuermerkmal dieser Elementgruppe „Document level charge VAT category code“ (BT-102) der Wert „Standard rated“ angegeben ist, muss in der Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) mindestens einen Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) gleich dem Wert „Standard rated“ enthalten.</assert>
      <assert test="(count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;Z&apos;])=0 and count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;Z&apos;])=0 and count(//ram:CategoryTradeTax[ram:CategoryCode=&apos;Z&apos;])=0) or ( count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;Z&apos;])=1 and (//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;Z&apos;] or //ram:CategoryTradeTax[ram:CategoryCode=&apos;Z&apos;]))">
	Eine Rechnung (INVOICE), die eine Position, einen Nachlass oder eine Abgabe auf der Rechnungsebene enthält, bei der als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens („Invoiced item VAT category code“ (BT-151), „Document level allowance VAT category code“ (BT-95) oder „Document level charge VAT category code“ (BT-102)) der Wert „Zero rated“ angegeben ist, muss in „VAT BREAKDOWN“ (BG-23) genau einen Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) gleich dem Wert „Zero rated“ enthalten.</assert>
      <assert test="(count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;E&apos;])=0 and count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;E&apos;])=0 and count(//ram:CategoryTradeTax[ram:CategoryCode=&apos;E&apos;])=0) or ( count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;E&apos;])=1 and (//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;E&apos;] or //ram:CategoryTradeTax[ram:CategoryCode=&apos;E&apos;]))">
	Eine Rechnung (INVOICE), die eine Position, einen Nachlass oder eine Abgabe auf der Rechnungsebene enthält, bei der als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens („Invoiced item VAT category code“ (BT-151), „Document level allowance VAT category code“ (BT-95) oder „Document level charge VAT category code“ (BT-102)) der Wert „Exempt from VAT“ angegeben ist, muss genau ein „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „Exempt from VAT“ enthalten.</assert>
      <assert test="(count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;AE&apos;])=0 and count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;AE&apos;])=0 and count(//ram:CategoryTradeTax[ram:CategoryCode=&apos;AE&apos;])=0) or ( count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;AE&apos;])=1 and (//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;AE&apos;] or //ram:CategoryTradeTax[ram:CategoryCode=&apos;AE&apos;]))">
	Eine Rechnung (INVOICE), die eine Position, einen Nachlass oder eine Abgabe auf der Rechnungsebene enthält, bei der als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens („Invoiced item VAT category code“ (BT-151), „Document level allowance VAT category code“ (BT-95) oder „Document level charge VAT category code“ (BT-102)) der Wert „VAT reverse charge“ angegeben ist, muss in „VAT BREAKDOWN“ (BG-23) genau einen Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „VAT Reverse charge“ enthalten.</assert>
      <assert test="(count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;K&apos;])=0 and count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;K&apos;])=0 and count(//ram:CategoryTradeTax[ram:CategoryCode=&apos;K&apos;])=0) or ( count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;K&apos;])=1 and (//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;K&apos;] or //ram:CategoryTradeTax[ram:CategoryCode=&apos;K&apos;]))">
	Eine Rechnung (INVOICE), die eine Position, einen Nachlass oder eine Abgabe auf der Rechnungsebene enthält, bei der als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens („Invoiced item VAT category code“ (BT-151), „Document level allowance VAT category code“ (BT-95) oder „Document level charge VAT category code“ (BT-102)) der Wert „intra-community supply“ angegeben ist, muss in „VAT BREAKDOWN“ (BG-23) genau einen Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „intra-community supply“ enthalten.</assert>
      <assert test="(count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;G&apos;])=0 and count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;G&apos;])=0 and count(//ram:CategoryTradeTax[ram:CategoryCode=&apos;G&apos;])=0) or ( count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;G&apos;])=1 and (//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;G&apos;] or //ram:CategoryTradeTax[ram:CategoryCode=&apos;G&apos;]))">
	Eine Rechnung (INVOICE), die eine Position, einen Nachlass oder eine Abgabe auf der Rechnungsebene enthält, bei der als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens („Invoiced item VAT category code“ (BT-151), „Document level allowance VAT category code“ (BT-95) oder „Document level charge VAT category code“ (BT-102)) der Wert „Export outside the EU“ angegeben ist, muss in „VAT BREAKDOWN“ (BG-23) genau einen Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „Export outside the EU“ enthalten.</assert>
      <assert test="not(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;O&apos;]) or (     count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;O&apos;])=1 and     (//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;O&apos;] or    //ram:CategoryTradeTax[ram:CategoryCode=&apos;O&apos;]))">
	Eine Rechnung (INVOICE), die eine Position, einen Nachlass oder eine Abgabe auf der Rechnungsebene enthält, bei der als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens („Invoiced item VAT category code“ (BT-151), „Document level allowance VAT category code“ (BT-95) oder „Document level charge VAT category code“ (BT-102)) der Wert „Not subject to VAT“ angegeben ist, muss genau eine „VAT BREAKDOWN“ (BG-23) mit dem Code der Umsatzsteuerkategorie „VAT category code“ (BT-118) mit dem Wert „Not subject to VAT“ enthalten.</assert>
      <assert test="((count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;L&apos;]) + count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;L&apos;])) &gt;=2 or not (//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;L&apos;])) and     ((count(//ram:CategoryTradeTax[ram:CategoryCode=&apos;L&apos;]) + count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;L&apos;])) &gt;=2 or not (//ram:CategoryTradeTax[ram:CategoryCode=&apos;L&apos;]))">
	Eine Rechnung (INVOICE), die eine Position, eine Abgabe auf der Dokumentenebene oder einen Nachlass auf der Rechnungsebene enthält, bei der als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens der Wert „IGIC“ angegeben ist, muss in der Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) mindestens einen Code der Umsatzsteuerkategorie mit dem Wert „IGIC“ enthalten.</assert>
      <assert test="((count(//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;M&apos;]) + count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;M&apos;])) &gt;=2 or not (//ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;M&apos;])) and     ((count(//ram:CategoryTradeTax[ram:CategoryCode=&apos;M&apos;]) + count(//ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax[ram:CategoryCode=&apos;M&apos;])) &gt;=2 or not (//ram:CategoryTradeTax[ram:CategoryCode=&apos;M&apos;]))">
	Eine Rechnung (INVOICE), die eine Position, eine Abgabe auf der Dokumentenebene oder einen Nachlass auf der Dokumentenebene enthält, bei der als Code der Umsatzsteuerkategorie des in Rechnung gestellten Postens der Wert „IPSI“ angegeben ist, muss in der Umsatzsteueraufschlüsselung „VAT BREAKDOWN“ (BG-23) mindestens einen Code der Umsatzsteuerkategorie gleich „IPSI“ enthalten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument">
      <assert test="count(ram:TypeCode)=1">
	Das Element 'ram:TypeCode' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:CategoryCode">
      <report test="true()">
	Element 'ram:CategoryCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:ControlRequirementIndicator">
      <report test="true()">
	Element 'ram:ControlRequirementIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:CopyIndicator">
      <report test="true()">
	Element 'ram:CopyIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:EffectiveSpecifiedPeriod">
      <report test="true()">
	Element 'ram:EffectiveSpecifiedPeriod' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:GlobalID">
      <report test="true()">
	Element 'ram:GlobalID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:ID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote">
      <assert test="count(ram:Content)=1">
	Das Element 'ram:Content' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:ContentCode">
      <report test="true()">
	Element 'ram:ContentCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:Content[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:Content[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:Subject">
      <report test="true()">
	Element 'ram:Subject' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:SubjectCode">
      <let name="codeValue3" value="."/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=3]/enumeration[@value=$codeValue3]">
	Wert von 'ram:SubjectCode' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:SubjectCode[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:SubjectCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:SubjectCode[@listAgencyName]">
      <report test="true()">
	Attribut '@listAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:SubjectCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:SubjectCode[@listName]">
      <report test="true()">
	Attribut '@listName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:SubjectCode[@listSchemeURI]">
      <report test="true()">
	Attribut '@listSchemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:SubjectCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:SubjectCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IncludedNote/ram:SubjectCode[@name]">
      <report test="true()">
	Attribut '@name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IssueDateTime/udt:DateTime">
      <report test="true()">
	Element 'udt:DateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IssueDateTime/udt:DateTimeString">
      <assert test="@format">
	Das Attribut '@format' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IssueDateTime/udt:DateTimeString[@format]">
      <let name="codeValue2" value="@format"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=2]/enumeration[@value=$codeValue2]">
	Wert von '@format' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:IssuerTradeParty">
      <report test="true()">
	Element 'ram:IssuerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:LanguageID">
      <report test="true()">
	Element 'ram:LanguageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:PreviousRevisionID">
      <report test="true()">
	Element 'ram:PreviousRevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:Purpose">
      <report test="true()">
	Element 'ram:Purpose' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:PurposeCode">
      <report test="true()">
	Element 'ram:PurposeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:RevisionDateTime">
      <report test="true()">
	Element 'ram:RevisionDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:RevisionID">
      <report test="true()">
	Element 'ram:RevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:TypeCode">
      <let name="codeValue1" value="."/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=1]/enumeration[@value=$codeValue1]">
	Wert von 'ram:TypeCode' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:TypeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:TypeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:TypeCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:TypeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:TypeCode[@name]">
      <report test="true()">
	Attribut '@name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocument/ram:VersionID">
      <report test="true()">
	Element 'ram:VersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext">
      <assert test="count(ram:BusinessProcessSpecifiedDocumentContextParameter)&lt;=1">
	Das Element 'ram:BusinessProcessSpecifiedDocumentContextParameter' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:GuidelineSpecifiedDocumentContextParameter)=1">
	Das Element 'ram:GuidelineSpecifiedDocumentContextParameter' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:ApplicationSpecifiedDocumentContextParameter">
      <report test="true()">
	Element 'ram:ApplicationSpecifiedDocumentContextParameter' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:BIMSpecifiedDocumentContextParameter">
      <report test="true()">
	Element 'ram:BIMSpecifiedDocumentContextParameter' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:BusinessProcessSpecifiedDocumentContextParameter/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:BusinessProcessSpecifiedDocumentContextParameter/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:BusinessProcessSpecifiedDocumentContextParameter/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:BusinessProcessSpecifiedDocumentContextParameter/ram:ID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:BusinessProcessSpecifiedDocumentContextParameter/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:BusinessProcessSpecifiedDocumentContextParameter/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:BusinessProcessSpecifiedDocumentContextParameter/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:BusinessProcessSpecifiedDocumentContextParameter/ram:SpecifiedDocumentVersion">
      <report test="true()">
	Element 'ram:SpecifiedDocumentVersion' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:BusinessProcessSpecifiedDocumentContextParameter/ram:Value">
      <report test="true()">
	Element 'ram:Value' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter">
      <assert test="count(ram:ID)=1">
	Das Element 'ram:ID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter/ram:ID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter/ram:SpecifiedDocumentVersion">
      <report test="true()">
	Element 'ram:SpecifiedDocumentVersion' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:GuidelineSpecifiedDocumentContextParameter/ram:Value">
      <report test="true()">
	Element 'ram:Value' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:MessageStandardSpecifiedDocumentContextParameter">
      <report test="true()">
	Element 'ram:MessageStandardSpecifiedDocumentContextParameter' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:ScenarioSpecifiedDocumentContextParameter">
      <report test="true()">
	Element 'ram:ScenarioSpecifiedDocumentContextParameter' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:SpecifiedTransactionID">
      <report test="true()">
	Element 'ram:SpecifiedTransactionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:SubsetSpecifiedDocumentContextParameter">
      <report test="true()">
	Element 'ram:SubsetSpecifiedDocumentContextParameter' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ExchangedDocumentContext/ram:TestIndicator">
      <report test="true()">
	Element 'ram:TestIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction">
      <assert test="count(ram:IncludedSupplyChainTradeLineItem)&gt;=1">
	Das Element 'ram:IncludedSupplyChainTradeLineItem' muss mindestens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement">
      <assert test="count(ram:SellerTradeParty)=1">
	Das Element 'ram:SellerTradeParty' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:BuyerTradeParty)=1">
	Das Element 'ram:BuyerTradeParty' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument">
      <assert test="count(ram:IssuerAssignedID)=1">
	Das Element 'ram:IssuerAssignedID' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:TypeCode)=1">
	Das Element 'ram:TypeCode' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:Name)&lt;=1">
	Das Element 'ram:Name' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:AttachmentBinaryObject)&lt;=1">
	Das Element 'ram:AttachmentBinaryObject' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:AttachedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:AttachedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:AttachmentBinaryObject">
      <assert test="@mimeCode">
	Das Attribut '@mimeCode' ist erforderlich in diesem Kontext.</assert>
      <assert test="@filename">
	Das Attribut '@filename' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:AttachmentBinaryObject[@characterSetCode]">
      <report test="true()">
	Attribut '@characterSetCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:AttachmentBinaryObject[@encodingCode]">
      <report test="true()">
	Attribut '@encodingCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:AttachmentBinaryObject[@format]">
      <report test="true()">
	Attribut '@format' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:AttachmentBinaryObject[@mimeCode]">
      <let name="codeValue19" value="@mimeCode"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=19]/enumeration[@value=$codeValue19]">
	Wert von '@mimeCode' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:AttachmentBinaryObject[@uri]">
      <report test="true()">
	Attribut '@uri' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:CopyIndicator">
      <report test="true()">
	Element 'ram:CopyIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:EffectiveSpecifiedPeriod">
      <report test="true()">
	Element 'ram:EffectiveSpecifiedPeriod' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:FormattedIssueDateTime">
      <report test="true()">
	Element 'ram:FormattedIssueDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:GlobalID">
      <report test="true()">
	Element 'ram:GlobalID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:Information">
      <report test="true()">
	Element 'ram:Information' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:IssuerTradeParty">
      <report test="true()">
	Element 'ram:IssuerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:LineID">
      <report test="true()">
	Element 'ram:LineID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:Name[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:Name[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:PreviousRevisionID">
      <report test="true()">
	Element 'ram:PreviousRevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode[@name]">
      <report test="true()">
	Attribut '@name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:RevisionID">
      <report test="true()">
	Element 'ram:RevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:SectionName">
      <report test="true()">
	Element 'ram:SectionName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:StatusCode">
      <report test="true()">
	Element 'ram:StatusCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:TypeCode">
      <let name="codeValue18" value="."/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=18]/enumeration[@value=$codeValue18]">
	Wert von 'ram:TypeCode' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:TypeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:TypeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:TypeCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:TypeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:TypeCode[@name]">
      <report test="true()">
	Attribut '@name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:URIID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:URIID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:URIID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:URIID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:URIID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:URIID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:AdditionalReferencedDocument/ram:URIID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ApplicableTradeDeliveryTerms">
      <report test="true()">
	Element 'ram:ApplicableTradeDeliveryTerms' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerAgentTradeParty">
      <report test="true()">
	Element 'ram:BuyerAgentTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerAssignedAccountantTradeParty">
      <report test="true()">
	Element 'ram:BuyerAssignedAccountantTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument">
      <assert test="count(ram:IssuerAssignedID)=1">
	Das Element 'ram:IssuerAssignedID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:AttachedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:AttachedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:AttachmentBinaryObject">
      <report test="true()">
	Element 'ram:AttachmentBinaryObject' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:CopyIndicator">
      <report test="true()">
	Element 'ram:CopyIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:EffectiveSpecifiedPeriod">
      <report test="true()">
	Element 'ram:EffectiveSpecifiedPeriod' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:FormattedIssueDateTime">
      <report test="true()">
	Element 'ram:FormattedIssueDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:GlobalID">
      <report test="true()">
	Element 'ram:GlobalID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:Information">
      <report test="true()">
	Element 'ram:Information' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:IssuerAssignedID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:IssuerAssignedID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:IssuerAssignedID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:IssuerAssignedID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:IssuerAssignedID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:IssuerAssignedID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:IssuerAssignedID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:IssuerTradeParty">
      <report test="true()">
	Element 'ram:IssuerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:LineID">
      <report test="true()">
	Element 'ram:LineID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:PreviousRevisionID">
      <report test="true()">
	Element 'ram:PreviousRevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:ReferenceTypeCode">
      <report test="true()">
	Element 'ram:ReferenceTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:RevisionID">
      <report test="true()">
	Element 'ram:RevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:SectionName">
      <report test="true()">
	Element 'ram:SectionName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:StatusCode">
      <report test="true()">
	Element 'ram:StatusCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerOrderReferencedDocument/ram:URIID">
      <report test="true()">
	Element 'ram:URIID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerReference[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerReference[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerRequisitionerTradeParty">
      <report test="true()">
	Element 'ram:BuyerRequisitionerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTaxRepresentativeTradeParty">
      <report test="true()">
	Element 'ram:BuyerTaxRepresentativeTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty">
      <assert test="count(ram:ID)&lt;=1">
	Das Element 'ram:ID' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:Name)=1">
	Das Element 'ram:Name' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:DefinedTradeContact)&lt;=1">
	Das Element 'ram:DefinedTradeContact' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:PostalTradeAddress)=1">
	Das Element 'ram:PostalTradeAddress' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:URIUniversalCommunication)&lt;=1">
	Das Element 'ram:URIUniversalCommunication' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:SpecifiedTaxRegistration)&lt;=1">
	Das Element 'ram:SpecifiedTaxRegistration' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:DepartmentName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:DepartmentName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:DirectTelephoneUniversalCommunication">
      <report test="true()">
	Element 'ram:DirectTelephoneUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication">
      <assert test="count(ram:URIID)=1">
	Das Element 'ram:URIID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:ChannelCode">
      <report test="true()">
	Element 'ram:ChannelCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:CompleteNumber">
      <report test="true()">
	Element 'ram:CompleteNumber' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:FaxUniversalCommunication">
      <report test="true()">
	Element 'ram:FaxUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:InstantMessagingUniversalCommunication">
      <report test="true()">
	Element 'ram:InstantMessagingUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:JobTitle">
      <report test="true()">
	Element 'ram:JobTitle' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:MobileTelephoneUniversalCommunication">
      <report test="true()">
	Element 'ram:MobileTelephoneUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:PersonID">
      <report test="true()">
	Element 'ram:PersonID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:PersonName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:PersonName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:Responsibility">
      <report test="true()">
	Element 'ram:Responsibility' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:SpecifiedContactPerson">
      <report test="true()">
	Element 'ram:SpecifiedContactPerson' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:SpecifiedNote">
      <report test="true()">
	Element 'ram:SpecifiedNote' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication">
      <assert test="count(ram:CompleteNumber)=1">
	Das Element 'ram:CompleteNumber' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication/ram:ChannelCode">
      <report test="true()">
	Element 'ram:ChannelCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication/ram:CompleteNumber[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication/ram:CompleteNumber[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication/ram:URIID">
      <report test="true()">
	Element 'ram:URIID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:TelexUniversalCommunication">
      <report test="true()">
	Element 'ram:TelexUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:DefinedTradeContact/ram:VOIPUniversalCommunication">
      <report test="true()">
	Element 'ram:VOIPUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:Description">
      <report test="true()">
	Element 'ram:Description' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:EndPointURIUniversalCommunication">
      <report test="true()">
	Element 'ram:EndPointURIUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:GlobalID">
      <assert test="@schemeID">
	Das Attribut '@schemeID' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:GlobalID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:GlobalID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:GlobalID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:GlobalID[@schemeID]">
      <let name="codeValue14" value="@schemeID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=14]/enumeration[@value=$codeValue14]">
	Wert von '@schemeID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:GlobalID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:GlobalID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:GlobalID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:ID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:LogoAssociatedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:LogoAssociatedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:Name[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:Name[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress">
      <assert test="count(ram:CountryID)=1">
	Das Element 'ram:CountryID' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:CountrySubDivisionName)&lt;=1">
	Das Element 'ram:CountrySubDivisionName' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:AdditionalStreetName">
      <report test="true()">
	Element 'ram:AdditionalStreetName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:AttentionOf">
      <report test="true()">
	Element 'ram:AttentionOf' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:BuildingName">
      <report test="true()">
	Element 'ram:BuildingName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:BuildingNumber">
      <report test="true()">
	Element 'ram:BuildingNumber' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:CareOf">
      <report test="true()">
	Element 'ram:CareOf' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:CityName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:CityName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:CitySubDivisionName">
      <report test="true()">
	Element 'ram:CitySubDivisionName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:CountryID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:CountryID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:CountryID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:CountryName">
      <report test="true()">
	Element 'ram:CountryName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:CountrySubDivisionID">
      <report test="true()">
	Element 'ram:CountrySubDivisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:CountrySubDivisionName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:CountrySubDivisionName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:DepartmentName">
      <report test="true()">
	Element 'ram:DepartmentName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:LineFive">
      <report test="true()">
	Element 'ram:LineFive' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:LineFour">
      <report test="true()">
	Element 'ram:LineFour' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:LineOne[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:LineOne[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:LineThree[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:LineThree[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:LineTwo[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:LineTwo[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:PostOfficeBox">
      <report test="true()">
	Element 'ram:PostOfficeBox' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listAgencyName]">
      <report test="true()">
	Attribut '@listAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listName]">
      <report test="true()">
	Attribut '@listName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listSchemeURI]">
      <report test="true()">
	Attribut '@listSchemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@name]">
      <report test="true()">
	Attribut '@name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:PostalTradeAddress/ram:StreetName">
      <report test="true()">
	Element 'ram:StreetName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:RoleCode">
      <report test="true()">
	Element 'ram:RoleCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:AuthorizedLegalRegistration">
      <report test="true()">
	Element 'ram:AuthorizedLegalRegistration' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeID]">
      <let name="codeValue15" value="@schemeID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=15]/enumeration[@value=$codeValue15]">
	Wert von '@schemeID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:LegalClassificationCode">
      <report test="true()">
	Element 'ram:LegalClassificationCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:PostalTradeAddress">
      <report test="true()">
	Element 'ram:PostalTradeAddress' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:TradingBusinessName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedLegalOrganization/ram:TradingBusinessName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration">
      <assert test="count(ram:ID)=1">
	Das Element 'ram:ID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:AssociatedRegisteredTax">
      <report test="true()">
	Element 'ram:AssociatedRegisteredTax' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID">
      <assert test="@schemeID">
	Das Attribut '@schemeID' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID]">
      <let name="codeValue16" value="@schemeID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=16]/enumeration[@value=$codeValue16]">
	Wert von '@schemeID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication">
      <assert test="count(ram:URIID)=1">
	Das Element 'ram:URIID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:ChannelCode">
      <report test="true()">
	Element 'ram:ChannelCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:CompleteNumber">
      <report test="true()">
	Element 'ram:CompleteNumber' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:URIID">
      <assert test="@schemeID">
	Das Attribut '@schemeID' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeID]">
      <let name="codeValue12" value="@schemeID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=12]/enumeration[@value=$codeValue12]">
	Wert von '@schemeID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument">
      <assert test="count(ram:IssuerAssignedID)=1">
	Das Element 'ram:IssuerAssignedID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:AttachedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:AttachedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:AttachmentBinaryObject">
      <report test="true()">
	Element 'ram:AttachmentBinaryObject' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:CopyIndicator">
      <report test="true()">
	Element 'ram:CopyIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:EffectiveSpecifiedPeriod">
      <report test="true()">
	Element 'ram:EffectiveSpecifiedPeriod' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:FormattedIssueDateTime">
      <report test="true()">
	Element 'ram:FormattedIssueDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:GlobalID">
      <report test="true()">
	Element 'ram:GlobalID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:Information">
      <report test="true()">
	Element 'ram:Information' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:IssuerAssignedID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:IssuerAssignedID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:IssuerAssignedID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:IssuerAssignedID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:IssuerAssignedID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:IssuerAssignedID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:IssuerAssignedID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:IssuerTradeParty">
      <report test="true()">
	Element 'ram:IssuerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:LineID">
      <report test="true()">
	Element 'ram:LineID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:PreviousRevisionID">
      <report test="true()">
	Element 'ram:PreviousRevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:ReferenceTypeCode">
      <report test="true()">
	Element 'ram:ReferenceTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:RevisionID">
      <report test="true()">
	Element 'ram:RevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:SectionName">
      <report test="true()">
	Element 'ram:SectionName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:StatusCode">
      <report test="true()">
	Element 'ram:StatusCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ContractReferencedDocument/ram:URIID">
      <report test="true()">
	Element 'ram:URIID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:DemandForecastReferencedDocument">
      <report test="true()">
	Element 'ram:DemandForecastReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:OrderResponseReferencedDocument">
      <report test="true()">
	Element 'ram:OrderResponseReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:PriceListReferencedDocument">
      <report test="true()">
	Element 'ram:PriceListReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:ProductEndUserTradeParty">
      <report test="true()">
	Element 'ram:ProductEndUserTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:PromotionalDealReferencedDocument">
      <report test="true()">
	Element 'ram:PromotionalDealReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:PurchaseConditionsReferencedDocument">
      <report test="true()">
	Element 'ram:PurchaseConditionsReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:QuotationReferencedDocument">
      <report test="true()">
	Element 'ram:QuotationReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:Reference">
      <report test="true()">
	Element 'ram:Reference' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:RequisitionerReferencedDocument">
      <report test="true()">
	Element 'ram:RequisitionerReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SalesAgentTradeParty">
      <report test="true()">
	Element 'ram:SalesAgentTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerAssignedAccountantTradeParty">
      <report test="true()">
	Element 'ram:SellerAssignedAccountantTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument">
      <assert test="count(ram:IssuerAssignedID)=1">
	Das Element 'ram:IssuerAssignedID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:AttachedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:AttachedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:AttachmentBinaryObject">
      <report test="true()">
	Element 'ram:AttachmentBinaryObject' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:CopyIndicator">
      <report test="true()">
	Element 'ram:CopyIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:EffectiveSpecifiedPeriod">
      <report test="true()">
	Element 'ram:EffectiveSpecifiedPeriod' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:FormattedIssueDateTime">
      <report test="true()">
	Element 'ram:FormattedIssueDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:GlobalID">
      <report test="true()">
	Element 'ram:GlobalID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:Information">
      <report test="true()">
	Element 'ram:Information' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:IssuerAssignedID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:IssuerAssignedID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:IssuerAssignedID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:IssuerAssignedID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:IssuerAssignedID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:IssuerAssignedID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:IssuerAssignedID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:IssuerTradeParty">
      <report test="true()">
	Element 'ram:IssuerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:LineID">
      <report test="true()">
	Element 'ram:LineID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:PreviousRevisionID">
      <report test="true()">
	Element 'ram:PreviousRevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:ReferenceTypeCode">
      <report test="true()">
	Element 'ram:ReferenceTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:RevisionID">
      <report test="true()">
	Element 'ram:RevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:SectionName">
      <report test="true()">
	Element 'ram:SectionName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:StatusCode">
      <report test="true()">
	Element 'ram:StatusCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerOrderReferencedDocument/ram:URIID">
      <report test="true()">
	Element 'ram:URIID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty">
      <assert test="count(ram:Name)=1">
	Das Element 'ram:Name' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:PostalTradeAddress)=1">
	Das Element 'ram:PostalTradeAddress' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:SpecifiedTaxRegistration)=1">
	Das Element 'ram:SpecifiedTaxRegistration' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:DefinedTradeContact">
      <report test="true()">
	Element 'ram:DefinedTradeContact' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:Description">
      <report test="true()">
	Element 'ram:Description' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:EndPointURIUniversalCommunication">
      <report test="true()">
	Element 'ram:EndPointURIUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:GlobalID">
      <report test="true()">
	Element 'ram:GlobalID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:LogoAssociatedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:LogoAssociatedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:Name[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:Name[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress">
      <assert test="count(ram:CountryID)=1">
	Das Element 'ram:CountryID' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:CountrySubDivisionName)&lt;=1">
	Das Element 'ram:CountrySubDivisionName' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:AdditionalStreetName">
      <report test="true()">
	Element 'ram:AdditionalStreetName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:AttentionOf">
      <report test="true()">
	Element 'ram:AttentionOf' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:BuildingName">
      <report test="true()">
	Element 'ram:BuildingName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:BuildingNumber">
      <report test="true()">
	Element 'ram:BuildingNumber' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:CareOf">
      <report test="true()">
	Element 'ram:CareOf' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:CityName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:CityName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:CitySubDivisionName">
      <report test="true()">
	Element 'ram:CitySubDivisionName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:CountryID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:CountryID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:CountryID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:CountryName">
      <report test="true()">
	Element 'ram:CountryName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:CountrySubDivisionID">
      <report test="true()">
	Element 'ram:CountrySubDivisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:CountrySubDivisionName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:CountrySubDivisionName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:DepartmentName">
      <report test="true()">
	Element 'ram:DepartmentName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:LineFive">
      <report test="true()">
	Element 'ram:LineFive' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:LineFour">
      <report test="true()">
	Element 'ram:LineFour' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:LineOne[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:LineOne[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:LineThree[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:LineThree[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:LineTwo[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:LineTwo[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:PostOfficeBox">
      <report test="true()">
	Element 'ram:PostOfficeBox' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listAgencyName]">
      <report test="true()">
	Attribut '@listAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listName]">
      <report test="true()">
	Attribut '@listName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listSchemeURI]">
      <report test="true()">
	Attribut '@listSchemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@name]">
      <report test="true()">
	Attribut '@name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:PostalTradeAddress/ram:StreetName">
      <report test="true()">
	Element 'ram:StreetName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:RoleCode">
      <report test="true()">
	Element 'ram:RoleCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedLegalOrganization">
      <report test="true()">
	Element 'ram:SpecifiedLegalOrganization' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration">
      <assert test="count(ram:ID)=1">
	Das Element 'ram:ID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:AssociatedRegisteredTax">
      <report test="true()">
	Element 'ram:AssociatedRegisteredTax' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID">
      <assert test="@schemeID">
	Das Attribut '@schemeID' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID]">
      <let name="codeValue17" value="@schemeID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=17]/enumeration[@value=$codeValue17]">
	Wert von '@schemeID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTaxRepresentativeTradeParty/ram:URIUniversalCommunication">
      <report test="true()">
	Element 'ram:URIUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty">
      <assert test="count(ram:Name)=1">
	Das Element 'ram:Name' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:Description)&lt;=1">
	Das Element 'ram:Description' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:DefinedTradeContact)&lt;=1">
	Das Element 'ram:DefinedTradeContact' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:PostalTradeAddress)=1">
	Das Element 'ram:PostalTradeAddress' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:URIUniversalCommunication)&lt;=1">
	Das Element 'ram:URIUniversalCommunication' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:DepartmentName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:DepartmentName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:DirectTelephoneUniversalCommunication">
      <report test="true()">
	Element 'ram:DirectTelephoneUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication">
      <assert test="count(ram:URIID)=1">
	Das Element 'ram:URIID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:ChannelCode">
      <report test="true()">
	Element 'ram:ChannelCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:CompleteNumber">
      <report test="true()">
	Element 'ram:CompleteNumber' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:EmailURIUniversalCommunication/ram:URIID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:FaxUniversalCommunication">
      <report test="true()">
	Element 'ram:FaxUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:InstantMessagingUniversalCommunication">
      <report test="true()">
	Element 'ram:InstantMessagingUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:JobTitle">
      <report test="true()">
	Element 'ram:JobTitle' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:MobileTelephoneUniversalCommunication">
      <report test="true()">
	Element 'ram:MobileTelephoneUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:PersonID">
      <report test="true()">
	Element 'ram:PersonID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:PersonName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:PersonName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:Responsibility">
      <report test="true()">
	Element 'ram:Responsibility' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:SpecifiedContactPerson">
      <report test="true()">
	Element 'ram:SpecifiedContactPerson' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:SpecifiedNote">
      <report test="true()">
	Element 'ram:SpecifiedNote' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication">
      <assert test="count(ram:CompleteNumber)=1">
	Das Element 'ram:CompleteNumber' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication/ram:ChannelCode">
      <report test="true()">
	Element 'ram:ChannelCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication/ram:CompleteNumber[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication/ram:CompleteNumber[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:TelephoneUniversalCommunication/ram:URIID">
      <report test="true()">
	Element 'ram:URIID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:TelexUniversalCommunication">
      <report test="true()">
	Element 'ram:TelexUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:DefinedTradeContact/ram:VOIPUniversalCommunication">
      <report test="true()">
	Element 'ram:VOIPUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:Description[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:Description[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:EndPointURIUniversalCommunication">
      <report test="true()">
	Element 'ram:EndPointURIUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:GlobalID">
      <assert test="@schemeID">
	Das Attribut '@schemeID' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:GlobalID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:GlobalID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:GlobalID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:GlobalID[@schemeID]">
      <let name="codeValue10" value="@schemeID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=10]/enumeration[@value=$codeValue10]">
	Wert von '@schemeID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:GlobalID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:GlobalID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:GlobalID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:ID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:LogoAssociatedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:LogoAssociatedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:Name[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:Name[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress">
      <assert test="count(ram:CountryID)=1">
	Das Element 'ram:CountryID' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:CountrySubDivisionName)&lt;=1">
	Das Element 'ram:CountrySubDivisionName' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:AdditionalStreetName">
      <report test="true()">
	Element 'ram:AdditionalStreetName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:AttentionOf">
      <report test="true()">
	Element 'ram:AttentionOf' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:BuildingName">
      <report test="true()">
	Element 'ram:BuildingName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:BuildingNumber">
      <report test="true()">
	Element 'ram:BuildingNumber' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CareOf">
      <report test="true()">
	Element 'ram:CareOf' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CityName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CityName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CitySubDivisionName">
      <report test="true()">
	Element 'ram:CitySubDivisionName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CountryID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CountryID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CountryID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CountryName">
      <report test="true()">
	Element 'ram:CountryName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CountrySubDivisionID">
      <report test="true()">
	Element 'ram:CountrySubDivisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CountrySubDivisionName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CountrySubDivisionName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:DepartmentName">
      <report test="true()">
	Element 'ram:DepartmentName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:LineFive">
      <report test="true()">
	Element 'ram:LineFive' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:LineFour">
      <report test="true()">
	Element 'ram:LineFour' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:LineOne[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:LineOne[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:LineThree[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:LineThree[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:LineTwo[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:LineTwo[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:PostOfficeBox">
      <report test="true()">
	Element 'ram:PostOfficeBox' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listAgencyName]">
      <report test="true()">
	Attribut '@listAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listName]">
      <report test="true()">
	Attribut '@listName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listSchemeURI]">
      <report test="true()">
	Attribut '@listSchemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@name]">
      <report test="true()">
	Attribut '@name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:StreetName">
      <report test="true()">
	Element 'ram:StreetName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:RoleCode">
      <report test="true()">
	Element 'ram:RoleCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:AuthorizedLegalRegistration">
      <report test="true()">
	Element 'ram:AuthorizedLegalRegistration' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeID]">
      <let name="codeValue11" value="@schemeID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=11]/enumeration[@value=$codeValue11]">
	Wert von '@schemeID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:LegalClassificationCode">
      <report test="true()">
	Element 'ram:LegalClassificationCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:PostalTradeAddress">
      <report test="true()">
	Element 'ram:PostalTradeAddress' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:TradingBusinessName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedLegalOrganization/ram:TradingBusinessName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration">
      <assert test="count(ram:ID)=1">
	Das Element 'ram:ID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:AssociatedRegisteredTax">
      <report test="true()">
	Element 'ram:AssociatedRegisteredTax' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID">
      <assert test="@schemeID">
	Das Attribut '@schemeID' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeID]">
      <let name="codeValue13" value="@schemeID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=13]/enumeration[@value=$codeValue13]">
	Wert von '@schemeID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:SpecifiedTaxRegistration/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication">
      <assert test="count(ram:URIID)=1">
	Das Element 'ram:URIID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication/ram:ChannelCode">
      <report test="true()">
	Element 'ram:ChannelCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication/ram:CompleteNumber">
      <report test="true()">
	Element 'ram:CompleteNumber' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication/ram:URIID">
      <assert test="@schemeID">
	Das Attribut '@schemeID' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeID]">
      <let name="codeValue12" value="@schemeID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=12]/enumeration[@value=$codeValue12]">
	Wert von '@schemeID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:URIUniversalCommunication/ram:URIID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SpecifiedProcuringProject/ram:Description">
      <report test="true()">
	Element 'ram:Description' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SpecifiedProcuringProject/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SpecifiedProcuringProject/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SpecifiedProcuringProject/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SpecifiedProcuringProject/ram:ID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SpecifiedProcuringProject/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SpecifiedProcuringProject/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SpecifiedProcuringProject/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SpecifiedProcuringProject/ram:Name[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SpecifiedProcuringProject/ram:Name[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SupplyInstructionReferencedDocument">
      <report test="true()">
	Element 'ram:SupplyInstructionReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:UltimateCustomerOrderReferencedDocument">
      <report test="true()">
	Element 'ram:UltimateCustomerOrderReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery">
      <assert test="(ram:ShipToTradeParty/ram:PostalTradeAddress and ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CountryID!=&apos;&apos;) or not (ram:ShipToTradeParty/ram:PostalTradeAddress)">
	Jede Lieferadresse „DELIVER TO ADDRESS“ (BG-15) muss einen entsprechenden Ländercode „Deliver to country code“ (BT-80) enthalten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:Description">
      <report test="true()">
	Element 'ram:Description' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:DescriptionBinaryObject">
      <report test="true()">
	Element 'ram:DescriptionBinaryObject' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:EarliestOccurrenceDateTime">
      <report test="true()">
	Element 'ram:EarliestOccurrenceDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:LatestOccurrenceDateTime">
      <report test="true()">
	Element 'ram:LatestOccurrenceDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:OccurrenceDateTime/udt:DateTime">
      <report test="true()">
	Element 'udt:DateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:OccurrenceDateTime/udt:DateTimeString">
      <assert test="@format">
	Das Attribut '@format' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:OccurrenceDateTime/udt:DateTimeString[@format]">
      <let name="codeValue2" value="@format"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=2]/enumeration[@value=$codeValue2]">
	Wert von '@format' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:OccurrenceLogisticsLocation">
      <report test="true()">
	Element 'ram:OccurrenceLogisticsLocation' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:OccurrenceSpecifiedPeriod">
      <report test="true()">
	Element 'ram:OccurrenceSpecifiedPeriod' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDeliverySupplyChainEvent/ram:UnitQuantity">
      <report test="true()">
	Element 'ram:UnitQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualDespatchSupplyChainEvent">
      <report test="true()">
	Element 'ram:ActualDespatchSupplyChainEvent' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualPickUpSupplyChainEvent">
      <report test="true()">
	Element 'ram:ActualPickUpSupplyChainEvent' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ActualReceiptSupplyChainEvent">
      <report test="true()">
	Element 'ram:ActualReceiptSupplyChainEvent' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:AdditionalReferencedDocument">
      <report test="true()">
	Element 'ram:AdditionalReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ConsumptionReportReferencedDocument">
      <report test="true()">
	Element 'ram:ConsumptionReportReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DeliveryNoteReferencedDocument">
      <report test="true()">
	Element 'ram:DeliveryNoteReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument">
      <assert test="count(ram:IssuerAssignedID)=1">
	Das Element 'ram:IssuerAssignedID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:AttachedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:AttachedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:AttachmentBinaryObject">
      <report test="true()">
	Element 'ram:AttachmentBinaryObject' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:CopyIndicator">
      <report test="true()">
	Element 'ram:CopyIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:EffectiveSpecifiedPeriod">
      <report test="true()">
	Element 'ram:EffectiveSpecifiedPeriod' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:FormattedIssueDateTime">
      <report test="true()">
	Element 'ram:FormattedIssueDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:GlobalID">
      <report test="true()">
	Element 'ram:GlobalID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:Information">
      <report test="true()">
	Element 'ram:Information' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:IssuerAssignedID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:IssuerAssignedID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:IssuerAssignedID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:IssuerAssignedID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:IssuerAssignedID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:IssuerAssignedID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:IssuerAssignedID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:IssuerTradeParty">
      <report test="true()">
	Element 'ram:IssuerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:LineID">
      <report test="true()">
	Element 'ram:LineID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:PreviousRevisionID">
      <report test="true()">
	Element 'ram:PreviousRevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:ReferenceTypeCode">
      <report test="true()">
	Element 'ram:ReferenceTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:RevisionID">
      <report test="true()">
	Element 'ram:RevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:SectionName">
      <report test="true()">
	Element 'ram:SectionName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:StatusCode">
      <report test="true()">
	Element 'ram:StatusCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:DespatchAdviceReferencedDocument/ram:URIID">
      <report test="true()">
	Element 'ram:URIID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:PackingListReferencedDocument">
      <report test="true()">
	Element 'ram:PackingListReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:PreviousDeliverySupplyChainEvent">
      <report test="true()">
	Element 'ram:PreviousDeliverySupplyChainEvent' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument">
      <assert test="count(ram:IssuerAssignedID)=1">
	Das Element 'ram:IssuerAssignedID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:AttachedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:AttachedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:AttachmentBinaryObject">
      <report test="true()">
	Element 'ram:AttachmentBinaryObject' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:CopyIndicator">
      <report test="true()">
	Element 'ram:CopyIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:EffectiveSpecifiedPeriod">
      <report test="true()">
	Element 'ram:EffectiveSpecifiedPeriod' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:FormattedIssueDateTime">
      <report test="true()">
	Element 'ram:FormattedIssueDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:GlobalID">
      <report test="true()">
	Element 'ram:GlobalID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:Information">
      <report test="true()">
	Element 'ram:Information' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:IssuerAssignedID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:IssuerAssignedID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:IssuerAssignedID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:IssuerAssignedID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:IssuerAssignedID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:IssuerAssignedID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:IssuerAssignedID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:IssuerTradeParty">
      <report test="true()">
	Element 'ram:IssuerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:LineID">
      <report test="true()">
	Element 'ram:LineID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:PreviousRevisionID">
      <report test="true()">
	Element 'ram:PreviousRevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:ReferenceTypeCode">
      <report test="true()">
	Element 'ram:ReferenceTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:RevisionID">
      <report test="true()">
	Element 'ram:RevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:SectionName">
      <report test="true()">
	Element 'ram:SectionName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:StatusCode">
      <report test="true()">
	Element 'ram:StatusCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ReceivingAdviceReferencedDocument/ram:URIID">
      <report test="true()">
	Element 'ram:URIID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:RelatedSupplyChainConsignment">
      <report test="true()">
	Element 'ram:RelatedSupplyChainConsignment' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipFromTradeParty">
      <report test="true()">
	Element 'ram:ShipFromTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty">
      <assert test="count(ram:ID)&lt;=1">
	Das Element 'ram:ID' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:GlobalID)&lt;=1">
	Das Element 'ram:GlobalID' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:DefinedTradeContact">
      <report test="true()">
	Element 'ram:DefinedTradeContact' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:Description">
      <report test="true()">
	Element 'ram:Description' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:EndPointURIUniversalCommunication">
      <report test="true()">
	Element 'ram:EndPointURIUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:GlobalID">
      <assert test="@schemeID">
	Das Attribut '@schemeID' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:GlobalID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:GlobalID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:GlobalID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:GlobalID[@schemeID]">
      <let name="codeValue20" value="@schemeID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=20]/enumeration[@value=$codeValue20]">
	Wert von '@schemeID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:GlobalID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:GlobalID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:GlobalID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:ID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:LogoAssociatedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:LogoAssociatedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:Name[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:Name[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress">
      <assert test="count(ram:CountryID)=1">
	Das Element 'ram:CountryID' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:CountrySubDivisionName)&lt;=1">
	Das Element 'ram:CountrySubDivisionName' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:AdditionalStreetName">
      <report test="true()">
	Element 'ram:AdditionalStreetName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:AttentionOf">
      <report test="true()">
	Element 'ram:AttentionOf' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:BuildingName">
      <report test="true()">
	Element 'ram:BuildingName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:BuildingNumber">
      <report test="true()">
	Element 'ram:BuildingNumber' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CareOf">
      <report test="true()">
	Element 'ram:CareOf' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CityName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CityName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CitySubDivisionName">
      <report test="true()">
	Element 'ram:CitySubDivisionName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CountryID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CountryID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CountryID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CountryName">
      <report test="true()">
	Element 'ram:CountryName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CountrySubDivisionID">
      <report test="true()">
	Element 'ram:CountrySubDivisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CountrySubDivisionName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:CountrySubDivisionName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:DepartmentName">
      <report test="true()">
	Element 'ram:DepartmentName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:LineFive">
      <report test="true()">
	Element 'ram:LineFive' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:LineFour">
      <report test="true()">
	Element 'ram:LineFour' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:LineOne[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:LineOne[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:LineThree[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:LineThree[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:LineTwo[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:LineTwo[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:PostOfficeBox">
      <report test="true()">
	Element 'ram:PostOfficeBox' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listAgencyName]">
      <report test="true()">
	Attribut '@listAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listName]">
      <report test="true()">
	Attribut '@listName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listSchemeURI]">
      <report test="true()">
	Attribut '@listSchemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:PostcodeCode[@name]">
      <report test="true()">
	Attribut '@name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:PostalTradeAddress/ram:StreetName">
      <report test="true()">
	Element 'ram:StreetName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:RoleCode">
      <report test="true()">
	Element 'ram:RoleCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:SpecifiedLegalOrganization">
      <report test="true()">
	Element 'ram:SpecifiedLegalOrganization' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:SpecifiedTaxRegistration">
      <report test="true()">
	Element 'ram:SpecifiedTaxRegistration' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:ShipToTradeParty/ram:URIUniversalCommunication">
      <report test="true()">
	Element 'ram:URIUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeDelivery/ram:UltimateShipToTradeParty">
      <report test="true()">
	Element 'ram:UltimateShipToTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement">
      <assert test="count(ram:PaymentReference)&lt;=1">
	Das Element 'ram:PaymentReference' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:InvoiceCurrencyCode)=1">
	Das Element 'ram:InvoiceCurrencyCode' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:ApplicableTradeTax)&gt;=1">
	Das Element 'ram:ApplicableTradeTax' muss mindestens 1 mal auftreten.</assert>
      <assert test="count(ram:SpecifiedTradePaymentTerms)&lt;=1">
	Das Element 'ram:SpecifiedTradePaymentTerms' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:SpecifiedTradeSettlementHeaderMonetarySummation)=1">
	Das Element 'ram:SpecifiedTradeSettlementHeaderMonetarySummation' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:ReceivableSpecifiedTradeAccountingAccount)&lt;=1">
	Das Element 'ram:ReceivableSpecifiedTradeAccountingAccount' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax">
      <assert test="count(ram:CalculatedAmount)=1">
	Das Element 'ram:CalculatedAmount' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:TypeCode)=1">
	Das Element 'ram:TypeCode' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:BasisAmount)=1">
	Das Element 'ram:BasisAmount' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:CategoryCode)=1">
	Das Element 'ram:CategoryCode' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:AllowanceChargeBasisAmount">
      <report test="true()">
	Element 'ram:AllowanceChargeBasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:BasisAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:BasisAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:BasisQuantity">
      <report test="true()">
	Element 'ram:BasisQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:BuyerDeductibleTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:BuyerDeductibleTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:BuyerNonDeductibleTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:BuyerNonDeductibleTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:BuyerRepayableTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:BuyerRepayableTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CalculatedAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CalculatedAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CalculatedRate">
      <report test="true()">
	Element 'ram:CalculatedRate' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CalculationSequenceNumeric">
      <report test="true()">
	Element 'ram:CalculationSequenceNumeric' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode">
      <let name="codeValue23" value="."/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=23]/enumeration[@value=$codeValue23]">
	Wert von 'ram:CategoryCode' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CategoryName">
      <report test="true()">
	Element 'ram:CategoryName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CurrencyCode">
      <report test="true()">
	Element 'ram:CurrencyCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:CustomsDutyIndicator">
      <report test="true()">
	Element 'ram:CustomsDutyIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:DueDateTypeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:DueDateTypeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:DueDateTypeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:DueDateTypeCode[@name]">
      <report test="true()">
	Attribut '@name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReasonCode">
      <let name="codeValue24" value="."/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=24]/enumeration[@value=$codeValue24]">
	Wert von 'ram:ExemptionReasonCode' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReasonCode[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReasonCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReasonCode[@listAgencyName]">
      <report test="true()">
	Attribut '@listAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReasonCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReasonCode[@listName]">
      <report test="true()">
	Attribut '@listName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReasonCode[@listSchemeURI]">
      <report test="true()">
	Attribut '@listSchemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReasonCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReasonCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReasonCode[@name]">
      <report test="true()">
	Attribut '@name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReason[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReason[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:InformationAmount">
      <report test="true()">
	Element 'ram:InformationAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:Jurisdiction">
      <report test="true()">
	Element 'ram:Jurisdiction' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:LineTotalBasisAmount">
      <report test="true()">
	Element 'ram:LineTotalBasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:PlaceApplicableTradeLocation">
      <report test="true()">
	Element 'ram:PlaceApplicableTradeLocation' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:RateApplicablePercent[@format]">
      <report test="true()">
	Attribut '@format' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:SellerPayableTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:SellerPayableTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:SellerRefundableTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:SellerRefundableTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:ServiceSupplyTradeCountry">
      <report test="true()">
	Element 'ram:ServiceSupplyTradeCountry' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:SpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:SpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:TaxBasisAllowanceRate">
      <report test="true()">
	Element 'ram:TaxBasisAllowanceRate' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:TaxPointDate/udt:Date">
      <report test="true()">
	Element 'udt:Date' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:TaxPointDate/udt:DateString">
      <assert test="@format">
	Das Attribut '@format' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:TaxPointDate/udt:DateString[@format]">
      <let name="codeValue25" value="@format"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=25]/enumeration[@value=$codeValue25]">
	Wert von '@format' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:Type">
      <report test="true()">
	Element 'ram:Type' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:TypeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:TypeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:TypeCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:TypeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ApplicableTradeTax/ram:UnitBasisAmount">
      <report test="true()">
	Element 'ram:UnitBasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:CompleteDateTime">
      <report test="true()">
	Element 'ram:CompleteDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:ContinuousIndicator">
      <report test="true()">
	Element 'ram:ContinuousIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:Description">
      <report test="true()">
	Element 'ram:Description' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:DurationMeasure">
      <report test="true()">
	Element 'ram:DurationMeasure' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:EndDateTime/udt:DateTime">
      <report test="true()">
	Element 'udt:DateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:EndDateTime/udt:DateTimeString">
      <assert test="@format">
	Das Attribut '@format' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:EndDateTime/udt:DateTimeString[@format]">
      <let name="codeValue2" value="@format"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=2]/enumeration[@value=$codeValue2]">
	Wert von '@format' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:InclusiveIndicator">
      <report test="true()">
	Element 'ram:InclusiveIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:OpenIndicator">
      <report test="true()">
	Element 'ram:OpenIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:PurposeCode">
      <report test="true()">
	Element 'ram:PurposeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:SeasonCode">
      <report test="true()">
	Element 'ram:SeasonCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:SequenceNumeric">
      <report test="true()">
	Element 'ram:SequenceNumeric' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:StartDateFlexibilityCode">
      <report test="true()">
	Element 'ram:StartDateFlexibilityCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:StartDateTime/udt:DateTime">
      <report test="true()">
	Element 'udt:DateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:StartDateTime/udt:DateTimeString">
      <assert test="@format">
	Das Attribut '@format' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:BillingSpecifiedPeriod/ram:StartDateTime/udt:DateTimeString[@format]">
      <let name="codeValue2" value="@format"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=2]/enumeration[@value=$codeValue2]">
	Wert von '@format' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:CreditReason">
      <report test="true()">
	Element 'ram:CreditReason' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:CreditReasonCode">
      <report test="true()">
	Element 'ram:CreditReasonCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:CreditorReferenceID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:CreditorReferenceID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:CreditorReferenceID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:CreditorReferenceID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:CreditorReferenceID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:CreditorReferenceID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:CreditorReferenceID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:CreditorReferenceIssuerID">
      <report test="true()">
	Element 'ram:CreditorReferenceIssuerID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:CreditorReferenceType">
      <report test="true()">
	Element 'ram:CreditorReferenceType' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:CreditorReferenceTypeCode">
      <report test="true()">
	Element 'ram:CreditorReferenceTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:DuePayableAmount">
      <report test="true()">
	Element 'ram:DuePayableAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:FactoringAgreementReferencedDocument">
      <report test="true()">
	Element 'ram:FactoringAgreementReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:FactoringListReferencedDocument">
      <report test="true()">
	Element 'ram:FactoringListReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceApplicableTradeCurrencyExchange">
      <report test="true()">
	Element 'ram:InvoiceApplicableTradeCurrencyExchange' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceCurrencyCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceDateTime">
      <report test="true()">
	Element 'ram:InvoiceDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceIssuerReference">
      <report test="true()">
	Element 'ram:InvoiceIssuerReference' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument">
      <assert test="(ram:IssuerAssignedID!=&apos;&apos;)">
	Jede Bezugnahme auf eine vorausgegangene Rechnung „Preceding Invoice reference“ (BT-25) muss die Nummer der vorausgegangenen Rechnung enthalten.</assert>
      <assert test="count(ram:IssuerAssignedID)=1">
	Das Element 'ram:IssuerAssignedID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:AttachedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:AttachedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:AttachmentBinaryObject">
      <report test="true()">
	Element 'ram:AttachmentBinaryObject' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:CopyIndicator">
      <report test="true()">
	Element 'ram:CopyIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:EffectiveSpecifiedPeriod">
      <report test="true()">
	Element 'ram:EffectiveSpecifiedPeriod' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:FormattedIssueDateTime/qdt:DateTimeString">
      <assert test="@format">
	Das Attribut '@format' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:FormattedIssueDateTime/qdt:DateTimeString[@format]">
      <let name="codeValue28" value="@format"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=28]/enumeration[@value=$codeValue28]">
	Wert von '@format' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:GlobalID">
      <report test="true()">
	Element 'ram:GlobalID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:Information">
      <report test="true()">
	Element 'ram:Information' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:IssuerAssignedID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:IssuerAssignedID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:IssuerAssignedID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:IssuerAssignedID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:IssuerAssignedID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:IssuerAssignedID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:IssuerAssignedID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:IssuerTradeParty">
      <report test="true()">
	Element 'ram:IssuerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:LineID">
      <report test="true()">
	Element 'ram:LineID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:PreviousRevisionID">
      <report test="true()">
	Element 'ram:PreviousRevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:ReferenceTypeCode">
      <report test="true()">
	Element 'ram:ReferenceTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:RevisionID">
      <report test="true()">
	Element 'ram:RevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:SectionName">
      <report test="true()">
	Element 'ram:SectionName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:StatusCode">
      <report test="true()">
	Element 'ram:StatusCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceReferencedDocument/ram:URIID">
      <report test="true()">
	Element 'ram:URIID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoiceeTradeParty">
      <report test="true()">
	Element 'ram:InvoiceeTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:InvoicerTradeParty">
      <report test="true()">
	Element 'ram:InvoicerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:LetterOfCreditReferencedDocument">
      <report test="true()">
	Element 'ram:LetterOfCreditReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:NextInvoiceDateTime">
      <report test="true()">
	Element 'ram:NextInvoiceDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayableSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:PayableSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty">
      <assert test="count(ram:ID)&lt;=1">
	Das Element 'ram:ID' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:GlobalID)&lt;=1">
	Das Element 'ram:GlobalID' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:Name)=1">
	Das Element 'ram:Name' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:DefinedTradeContact">
      <report test="true()">
	Element 'ram:DefinedTradeContact' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:Description">
      <report test="true()">
	Element 'ram:Description' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:EndPointURIUniversalCommunication">
      <report test="true()">
	Element 'ram:EndPointURIUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:GlobalID">
      <assert test="@schemeID">
	Das Attribut '@schemeID' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:GlobalID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:GlobalID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:GlobalID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:GlobalID[@schemeID]">
      <let name="codeValue21" value="@schemeID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=21]/enumeration[@value=$codeValue21]">
	Wert von '@schemeID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:GlobalID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:GlobalID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:GlobalID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:ID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:LogoAssociatedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:LogoAssociatedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:Name[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:Name[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:PostalTradeAddress">
      <report test="true()">
	Element 'ram:PostalTradeAddress' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:RoleCode">
      <report test="true()">
	Element 'ram:RoleCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:AuthorizedLegalRegistration">
      <report test="true()">
	Element 'ram:AuthorizedLegalRegistration' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeID]">
      <let name="codeValue22" value="@schemeID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=22]/enumeration[@value=$codeValue22]">
	Wert von '@schemeID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:LegalClassificationCode">
      <report test="true()">
	Element 'ram:LegalClassificationCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:PostalTradeAddress">
      <report test="true()">
	Element 'ram:PostalTradeAddress' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:SpecifiedLegalOrganization/ram:TradingBusinessName">
      <report test="true()">
	Element 'ram:TradingBusinessName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:SpecifiedTaxRegistration">
      <report test="true()">
	Element 'ram:SpecifiedTaxRegistration' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayeeTradeParty/ram:URIUniversalCommunication">
      <report test="true()">
	Element 'ram:URIUniversalCommunication' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PayerTradeParty">
      <report test="true()">
	Element 'ram:PayerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PaymentApplicableTradeCurrencyExchange">
      <report test="true()">
	Element 'ram:PaymentApplicableTradeCurrencyExchange' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PaymentCurrencyCode">
      <report test="true()">
	Element 'ram:PaymentCurrencyCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PaymentReference[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PaymentReference[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ProFormaInvoiceReferencedDocument">
      <report test="true()">
	Element 'ram:ProFormaInvoiceReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:PurchaseSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:PurchaseSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:AmountTypeCode">
      <report test="true()">
	Element 'ram:AmountTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:CostReferenceDimensionPattern">
      <report test="true()">
	Element 'ram:CostReferenceDimensionPattern' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:SetTriggerCode">
      <report test="true()">
	Element 'ram:SetTriggerCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SalesSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:SalesSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedAdvancePayment">
      <report test="true()">
	Element 'ram:SpecifiedAdvancePayment' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedFinancialAdjustment">
      <report test="true()">
	Element 'ram:SpecifiedFinancialAdjustment' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedLogisticsServiceCharge">
      <report test="true()">
	Element 'ram:SpecifiedLogisticsServiceCharge' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge">
      <assert test="count(ram:ChargeIndicator)=1">
	Das Element 'ram:ChargeIndicator' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:ActualAmount)=1">
	Das Element 'ram:ActualAmount' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:CategoryTradeTax)=1">
	Das Element 'ram:CategoryTradeTax' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ActualAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ActualAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ActualTradeCurrencyExchange">
      <report test="true()">
	Element 'ram:ActualTradeCurrencyExchange' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:BasisAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:BasisAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:BasisQuantity">
      <report test="true()">
	Element 'ram:BasisQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CalculationPercent[@format]">
      <report test="true()">
	Attribut '@format' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax">
      <assert test="count(ram:TypeCode)=1">
	Das Element 'ram:TypeCode' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:CategoryCode)=1">
	Das Element 'ram:CategoryCode' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:AllowanceChargeBasisAmount">
      <report test="true()">
	Element 'ram:AllowanceChargeBasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:BasisAmount">
      <report test="true()">
	Element 'ram:BasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:BasisQuantity">
      <report test="true()">
	Element 'ram:BasisQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:BuyerDeductibleTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:BuyerDeductibleTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:BuyerNonDeductibleTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:BuyerNonDeductibleTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:BuyerRepayableTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:BuyerRepayableTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:CalculatedAmount">
      <report test="true()">
	Element 'ram:CalculatedAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:CalculatedRate">
      <report test="true()">
	Element 'ram:CalculatedRate' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:CalculationSequenceNumeric">
      <report test="true()">
	Element 'ram:CalculationSequenceNumeric' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:CategoryCode">
      <let name="codeValue26" value="."/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=26]/enumeration[@value=$codeValue26]">
	Wert von 'ram:CategoryCode' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:CategoryCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:CategoryCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:CategoryCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:CategoryCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:CategoryName">
      <report test="true()">
	Element 'ram:CategoryName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:CurrencyCode">
      <report test="true()">
	Element 'ram:CurrencyCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:CustomsDutyIndicator">
      <report test="true()">
	Element 'ram:CustomsDutyIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:DueDateTypeCode">
      <report test="true()">
	Element 'ram:DueDateTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:ExemptionReason">
      <report test="true()">
	Element 'ram:ExemptionReason' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:ExemptionReasonCode">
      <report test="true()">
	Element 'ram:ExemptionReasonCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:InformationAmount">
      <report test="true()">
	Element 'ram:InformationAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:Jurisdiction">
      <report test="true()">
	Element 'ram:Jurisdiction' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:LineTotalBasisAmount">
      <report test="true()">
	Element 'ram:LineTotalBasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:PlaceApplicableTradeLocation">
      <report test="true()">
	Element 'ram:PlaceApplicableTradeLocation' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:RateApplicablePercent[@format]">
      <report test="true()">
	Attribut '@format' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:SellerPayableTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:SellerPayableTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:SellerRefundableTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:SellerRefundableTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:ServiceSupplyTradeCountry">
      <report test="true()">
	Element 'ram:ServiceSupplyTradeCountry' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:SpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:SpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:TaxBasisAllowanceRate">
      <report test="true()">
	Element 'ram:TaxBasisAllowanceRate' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:TaxPointDate">
      <report test="true()">
	Element 'ram:TaxPointDate' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:Type">
      <report test="true()">
	Element 'ram:Type' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:TypeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:TypeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:TypeCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:TypeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax/ram:UnitBasisAmount">
      <report test="true()">
	Element 'ram:UnitBasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ChargeIndicator/udt:IndicatorString">
      <report test="true()">
	Element 'udt:IndicatorString' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:PrepaidIndicator">
      <report test="true()">
	Element 'ram:PrepaidIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ReasonCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ReasonCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ReasonCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ReasonCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:Reason[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:Reason[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:SequenceNumeric">
      <report test="true()">
	Element 'ram:SequenceNumeric' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:UnitBasisAmount">
      <report test="true()">
	Element 'ram:UnitBasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms">
      <assert test="count(ram:Description)&lt;=1">
	Das Element 'ram:Description' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:DirectDebitMandateID)&lt;=1">
	Das Element 'ram:DirectDebitMandateID' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:ApplicableTradePaymentDiscountTerms">
      <report test="true()">
	Element 'ram:ApplicableTradePaymentDiscountTerms' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:ApplicableTradePaymentPenaltyTerms">
      <report test="true()">
	Element 'ram:ApplicableTradePaymentPenaltyTerms' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:Description[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:Description[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:DirectDebitMandateID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:DirectDebitMandateID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:DirectDebitMandateID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:DirectDebitMandateID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:DirectDebitMandateID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:DirectDebitMandateID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:DirectDebitMandateID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:DueDateDateTime/udt:DateTime">
      <report test="true()">
	Element 'udt:DateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:DueDateDateTime/udt:DateTimeString">
      <assert test="@format">
	Das Attribut '@format' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:DueDateDateTime/udt:DateTimeString[@format]">
      <let name="codeValue2" value="@format"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=2]/enumeration[@value=$codeValue2]">
	Wert von '@format' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:FromEventCode">
      <report test="true()">
	Element 'ram:FromEventCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:InstructionTypeCode">
      <report test="true()">
	Element 'ram:InstructionTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:PartialPaymentAmount">
      <report test="true()">
	Element 'ram:PartialPaymentAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:PartialPaymentPercent">
      <report test="true()">
	Element 'ram:PartialPaymentPercent' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:PayeeTradeParty">
      <report test="true()">
	Element 'ram:PayeeTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:PaymentMeansID">
      <report test="true()">
	Element 'ram:PaymentMeansID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:SettlementPeriodMeasure">
      <report test="true()">
	Element 'ram:SettlementPeriodMeasure' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradePaymentTerms/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementFinancialCard">
      <report test="true()">
	Element 'ram:SpecifiedTradeSettlementFinancialCard' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation">
      <assert test="count(ram:LineTotalAmount)=1">
	Das Element 'ram:LineTotalAmount' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:ChargeTotalAmount)&lt;=1">
	Das Element 'ram:ChargeTotalAmount' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:AllowanceTotalAmount)&lt;=1">
	Das Element 'ram:AllowanceTotalAmount' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:TaxBasisTotalAmount)=1">
	Das Element 'ram:TaxBasisTotalAmount' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:TaxTotalAmount)=1">
	Das Element 'ram:TaxTotalAmount' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:RoundingAmount)&lt;=1">
	Das Element 'ram:RoundingAmount' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:GrandTotalAmount)=1">
	Das Element 'ram:GrandTotalAmount' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:TotalPrepaidAmount)&lt;=1">
	Das Element 'ram:TotalPrepaidAmount' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:DuePayableAmount)=1">
	Das Element 'ram:DuePayableAmount' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:AllowanceTotalAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:AllowanceTotalAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:ChargeTotalAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:ChargeTotalAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:DuePayableAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:DuePayableAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:GrandTotalAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:GrandTotalAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:GrossLineTotalAmount">
      <report test="true()">
	Element 'ram:GrossLineTotalAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:InformationAmount">
      <report test="true()">
	Element 'ram:InformationAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:LineTotalAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:LineTotalAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:NetIncludingTaxesLineTotalAmount">
      <report test="true()">
	Element 'ram:NetIncludingTaxesLineTotalAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:NetLineTotalAmount">
      <report test="true()">
	Element 'ram:NetLineTotalAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:ProductValueExcludingTobaccoTaxInformationAmount">
      <report test="true()">
	Element 'ram:ProductValueExcludingTobaccoTaxInformationAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:RetailValueExcludingTaxInformationAmount">
      <report test="true()">
	Element 'ram:RetailValueExcludingTaxInformationAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:RoundingAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:RoundingAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxBasisTotalAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxBasisTotalAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxTotalAmount">
      <assert test="@currencyID">
	Das Attribut '@currencyID' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxTotalAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TaxTotalAmount[@currencyID]">
      <let name="codeValue27" value="@currencyID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=27]/enumeration[@value=$codeValue27]">
	Wert von '@currencyID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TotalAllowanceChargeAmount">
      <report test="true()">
	Element 'ram:TotalAllowanceChargeAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TotalDepositFeeInformationAmount">
      <report test="true()">
	Element 'ram:TotalDepositFeeInformationAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TotalDiscountAmount">
      <report test="true()">
	Element 'ram:TotalDiscountAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TotalPrepaidAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TotalPrepaidAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementHeaderMonetarySummation/ram:TotalRetailValueInformationAmount">
      <report test="true()">
	Element 'ram:TotalRetailValueInformationAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans">
      <assert test="count(ram:TypeCode)=1">
	Das Element 'ram:TypeCode' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:Information)&lt;=1">
	Das Element 'ram:Information' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard">
      <assert test="count(ram:ID)=1">
	Das Element 'ram:ID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:CardholderName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:CardholderName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:CreditAvailableAmount">
      <report test="true()">
	Element 'ram:CreditAvailableAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:CreditLimitAmount">
      <report test="true()">
	Element 'ram:CreditLimitAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:Description">
      <report test="true()">
	Element 'ram:Description' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:ExpiryDate">
      <report test="true()">
	Element 'ram:ExpiryDate' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:ID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:InterestRatePercent">
      <report test="true()">
	Element 'ram:InterestRatePercent' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:IssuingCompanyName">
      <report test="true()">
	Element 'ram:IssuingCompanyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:MicrochipIndicator">
      <report test="true()">
	Element 'ram:MicrochipIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:ValidFromDateTime">
      <report test="true()">
	Element 'ram:ValidFromDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ApplicableTradeSettlementFinancialCard/ram:VerificationNumeric">
      <report test="true()">
	Element 'ram:VerificationNumeric' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:GuaranteeMethodCode">
      <report test="true()">
	Element 'ram:GuaranteeMethodCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:Information[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:Information[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:AccountName[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:AccountName[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:IBANID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:IBANID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:IBANID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:IBANID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:IBANID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:IBANID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:IBANID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:ProprietaryID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:ProprietaryID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:ProprietaryID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:ProprietaryID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:ProprietaryID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:ProprietaryID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeePartyCreditorFinancialAccount/ram:ProprietaryID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution">
      <assert test="count(ram:BICID)=1">
	Das Element 'ram:BICID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:AustralianBSBID">
      <report test="true()">
	Element 'ram:AustralianBSBID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:AustrianBankleitzahlID">
      <report test="true()">
	Element 'ram:AustrianBankleitzahlID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:BICID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:BICID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:BICID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:BICID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:BICID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:BICID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:BICID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:CHIPSParticipantID">
      <report test="true()">
	Element 'ram:CHIPSParticipantID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:CHIPSUniversalID">
      <report test="true()">
	Element 'ram:CHIPSUniversalID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:CanadianPaymentsAssociationID">
      <report test="true()">
	Element 'ram:CanadianPaymentsAssociationID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:ClearingSystemName">
      <report test="true()">
	Element 'ram:ClearingSystemName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:FedwireRoutingNumberID">
      <report test="true()">
	Element 'ram:FedwireRoutingNumberID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:GermanBankleitzahlID">
      <report test="true()">
	Element 'ram:GermanBankleitzahlID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:HellenicBankID">
      <report test="true()">
	Element 'ram:HellenicBankID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:HongKongBankID">
      <report test="true()">
	Element 'ram:HongKongBankID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:IndianFinancialSystemID">
      <report test="true()">
	Element 'ram:IndianFinancialSystemID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:IrishNSCID">
      <report test="true()">
	Element 'ram:IrishNSCID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:ItalianDomesticID">
      <report test="true()">
	Element 'ram:ItalianDomesticID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:JapanFinancialInstitutionCommonID">
      <report test="true()">
	Element 'ram:JapanFinancialInstitutionCommonID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:LocationFinancialInstitutionAddress">
      <report test="true()">
	Element 'ram:LocationFinancialInstitutionAddress' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:NewZealandNCCID">
      <report test="true()">
	Element 'ram:NewZealandNCCID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:PolishNationalClearingID">
      <report test="true()">
	Element 'ram:PolishNationalClearingID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:PortugueseNCCID">
      <report test="true()">
	Element 'ram:PortugueseNCCID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:RussianCentralBankID">
      <report test="true()">
	Element 'ram:RussianCentralBankID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:SICID">
      <report test="true()">
	Element 'ram:SICID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:SouthAfricanNCCID">
      <report test="true()">
	Element 'ram:SouthAfricanNCCID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:SpanishDomesticInterbankingID">
      <report test="true()">
	Element 'ram:SpanishDomesticInterbankingID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:SubDivisionBranchFinancialInstitution">
      <report test="true()">
	Element 'ram:SubDivisionBranchFinancialInstitution' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:SwissBCID">
      <report test="true()">
	Element 'ram:SwissBCID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayeeSpecifiedCreditorFinancialInstitution/ram:UKSortCodeID">
      <report test="true()">
	Element 'ram:UKSortCodeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerPartyDebtorFinancialAccount">
      <assert test="count(ram:IBANID)=1">
	Das Element 'ram:IBANID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerPartyDebtorFinancialAccount/ram:AccountName">
      <report test="true()">
	Element 'ram:AccountName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerPartyDebtorFinancialAccount/ram:IBANID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerPartyDebtorFinancialAccount/ram:IBANID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerPartyDebtorFinancialAccount/ram:IBANID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerPartyDebtorFinancialAccount/ram:IBANID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerPartyDebtorFinancialAccount/ram:IBANID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerPartyDebtorFinancialAccount/ram:IBANID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerPartyDebtorFinancialAccount/ram:IBANID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerPartyDebtorFinancialAccount/ram:ProprietaryID">
      <report test="true()">
	Element 'ram:ProprietaryID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PayerSpecifiedDebtorFinancialInstitution">
      <report test="true()">
	Element 'ram:PayerSpecifiedDebtorFinancialInstitution' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PaymentChannelCode">
      <report test="true()">
	Element 'ram:PaymentChannelCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:PaymentMethodCode">
      <report test="true()">
	Element 'ram:PaymentMethodCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:TypeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:TypeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SpecifiedTradeSettlementPaymentMeans/ram:TypeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:SubtotalCalculatedTradeTax">
      <report test="true()">
	Element 'ram:SubtotalCalculatedTradeTax' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxApplicableTradeCurrencyExchange">
      <report test="true()">
	Element 'ram:TaxApplicableTradeCurrencyExchange' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:TaxCurrencyCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeSettlement/ram:UltimatePayeeTradeParty">
      <report test="true()">
	Element 'ram:UltimatePayeeTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem">
      <assert test="count(ram:SpecifiedTradeProduct)=1">
	Das Element 'ram:SpecifiedTradeProduct' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:SpecifiedLineTradeAgreement)=1">
	Das Element 'ram:SpecifiedLineTradeAgreement' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument">
      <assert test="count(ram:LineID)=1">
	Das Element 'ram:LineID' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:IncludedNote)&lt;=1">
	Das Element 'ram:IncludedNote' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:IncludedNote">
      <assert test="count(ram:Content)=1">
	Das Element 'ram:Content' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:IncludedNote/ram:ContentCode">
      <report test="true()">
	Element 'ram:ContentCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:IncludedNote/ram:Content[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:IncludedNote/ram:Content[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:IncludedNote/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:IncludedNote/ram:Subject">
      <report test="true()">
	Element 'ram:Subject' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:IncludedNote/ram:SubjectCode">
      <report test="true()">
	Element 'ram:SubjectCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:LineID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:LineID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:LineID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:LineID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:LineID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:LineID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:LineID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:LineStatusCode">
      <report test="true()">
	Element 'ram:LineStatusCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:LineStatusReasonCode">
      <report test="true()">
	Element 'ram:LineStatusReasonCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:AssociatedDocumentLineDocument/ram:ParentLineID">
      <report test="true()">
	Element 'ram:ParentLineID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:DescriptionCode">
      <report test="true()">
	Element 'ram:DescriptionCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:IncludedSubordinateTradeLineItem">
      <report test="true()">
	Element 'ram:IncludedSubordinateTradeLineItem' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement">
      <assert test="count(ram:NetPriceProductTradePrice)=1">
	Das Element 'ram:NetPriceProductTradePrice' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:AdditionalReferencedDocument">
      <report test="true()">
	Element 'ram:AdditionalReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:ApplicableTradeDeliveryTerms">
      <report test="true()">
	Element 'ram:ApplicableTradeDeliveryTerms' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:AttachedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:AttachedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:AttachmentBinaryObject">
      <report test="true()">
	Element 'ram:AttachmentBinaryObject' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:CopyIndicator">
      <report test="true()">
	Element 'ram:CopyIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:EffectiveSpecifiedPeriod">
      <report test="true()">
	Element 'ram:EffectiveSpecifiedPeriod' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:FormattedIssueDateTime">
      <report test="true()">
	Element 'ram:FormattedIssueDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:GlobalID">
      <report test="true()">
	Element 'ram:GlobalID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:Information">
      <report test="true()">
	Element 'ram:Information' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:IssuerAssignedID">
      <report test="true()">
	Element 'ram:IssuerAssignedID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:IssuerTradeParty">
      <report test="true()">
	Element 'ram:IssuerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:LineID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:LineID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:LineID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:LineID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:LineID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:LineID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:LineID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:PreviousRevisionID">
      <report test="true()">
	Element 'ram:PreviousRevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:ReferenceTypeCode">
      <report test="true()">
	Element 'ram:ReferenceTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:RevisionID">
      <report test="true()">
	Element 'ram:RevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:SectionName">
      <report test="true()">
	Element 'ram:SectionName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:StatusCode">
      <report test="true()">
	Element 'ram:StatusCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerOrderReferencedDocument/ram:URIID">
      <report test="true()">
	Element 'ram:URIID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerReference">
      <report test="true()">
	Element 'ram:BuyerReference' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:BuyerRequisitionerTradeParty">
      <report test="true()">
	Element 'ram:BuyerRequisitionerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:ContractReferencedDocument">
      <report test="true()">
	Element 'ram:ContractReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:DemandForecastReferencedDocument">
      <report test="true()">
	Element 'ram:DemandForecastReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice">
      <assert test="count(ram:ChargeAmount)=1">
	Das Element 'ram:ChargeAmount' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:AppliedTradeAllowanceCharge)&lt;=1">
	Das Element 'ram:AppliedTradeAllowanceCharge' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge">
      <assert test="count(ram:ActualAmount)=1">
	Das Element 'ram:ActualAmount' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ActualAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ActualAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ActualTradeCurrencyExchange">
      <report test="true()">
	Element 'ram:ActualTradeCurrencyExchange' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:BasisAmount">
      <report test="true()">
	Element 'ram:BasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:BasisQuantity">
      <report test="true()">
	Element 'ram:BasisQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:CalculationPercent">
      <report test="true()">
	Element 'ram:CalculationPercent' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:CategoryTradeTax">
      <report test="true()">
	Element 'ram:CategoryTradeTax' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ChargeIndicator">
      <report test="true()">
	Element 'ram:ChargeIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:PrepaidIndicator">
      <report test="true()">
	Element 'ram:PrepaidIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:Reason">
      <report test="true()">
	Element 'ram:Reason' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:ReasonCode">
      <report test="true()">
	Element 'ram:ReasonCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:SequenceNumeric">
      <report test="true()">
	Element 'ram:SequenceNumeric' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AppliedTradeAllowanceCharge/ram:UnitBasisAmount">
      <report test="true()">
	Element 'ram:UnitBasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:AssociatedReferencedDocument">
      <report test="true()">
	Element 'ram:AssociatedReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:BasisQuantity">
      <assert test="@unitCode">
	Das Attribut '@unitCode' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:BasisQuantity[@unitCodeListAgencyID]">
      <report test="true()">
	Attribut '@unitCodeListAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:BasisQuantity[@unitCodeListAgencyName]">
      <report test="true()">
	Attribut '@unitCodeListAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:BasisQuantity[@unitCodeListID]">
      <report test="true()">
	Attribut '@unitCodeListID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:BasisQuantity[@unitCode]">
      <let name="codeValue7" value="@unitCode"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=7]/enumeration[@value=$codeValue7]">
	Wert von '@unitCode' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:ChangeReason">
      <report test="true()">
	Element 'ram:ChangeReason' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:ChargeAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:ChargeAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:DeliveryTradeLocation">
      <report test="true()">
	Element 'ram:DeliveryTradeLocation' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:IncludedTradeTax">
      <report test="true()">
	Element 'ram:IncludedTradeTax' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:MaximumQuantity">
      <report test="true()">
	Element 'ram:MaximumQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:MinimumQuantity">
      <report test="true()">
	Element 'ram:MinimumQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:OrderUnitConversionFactorNumeric">
      <report test="true()">
	Element 'ram:OrderUnitConversionFactorNumeric' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:TradeComparisonReferencePrice">
      <report test="true()">
	Element 'ram:TradeComparisonReferencePrice' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:GrossPriceProductTradePrice/ram:ValiditySpecifiedPeriod">
      <report test="true()">
	Element 'ram:ValiditySpecifiedPeriod' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:IncludedSpecifiedMarketplace">
      <report test="true()">
	Element 'ram:IncludedSpecifiedMarketplace' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:ItemBuyerTradeParty">
      <report test="true()">
	Element 'ram:ItemBuyerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:ItemSellerTradeParty">
      <report test="true()">
	Element 'ram:ItemSellerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice">
      <assert test="count(ram:ChargeAmount)=1">
	Das Element 'ram:ChargeAmount' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:AppliedTradeAllowanceCharge">
      <report test="true()">
	Element 'ram:AppliedTradeAllowanceCharge' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:AssociatedReferencedDocument">
      <report test="true()">
	Element 'ram:AssociatedReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:BasisQuantity">
      <assert test="@unitCode">
	Das Attribut '@unitCode' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:BasisQuantity[@unitCodeListAgencyID]">
      <report test="true()">
	Attribut '@unitCodeListAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:BasisQuantity[@unitCodeListAgencyName]">
      <report test="true()">
	Attribut '@unitCodeListAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:BasisQuantity[@unitCodeListID]">
      <report test="true()">
	Attribut '@unitCodeListID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:BasisQuantity[@unitCode]">
      <let name="codeValue7" value="@unitCode"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=7]/enumeration[@value=$codeValue7]">
	Wert von '@unitCode' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:ChangeReason">
      <report test="true()">
	Element 'ram:ChangeReason' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:ChargeAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:ChargeAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:DeliveryTradeLocation">
      <report test="true()">
	Element 'ram:DeliveryTradeLocation' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:IncludedTradeTax">
      <report test="true()">
	Element 'ram:IncludedTradeTax' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:MaximumQuantity">
      <report test="true()">
	Element 'ram:MaximumQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:MinimumQuantity">
      <report test="true()">
	Element 'ram:MinimumQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:OrderUnitConversionFactorNumeric">
      <report test="true()">
	Element 'ram:OrderUnitConversionFactorNumeric' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:TradeComparisonReferencePrice">
      <report test="true()">
	Element 'ram:TradeComparisonReferencePrice' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:NetPriceProductTradePrice/ram:ValiditySpecifiedPeriod">
      <report test="true()">
	Element 'ram:ValiditySpecifiedPeriod' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:PromotionalDealReferencedDocument">
      <report test="true()">
	Element 'ram:PromotionalDealReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:QuotationReferencedDocument">
      <report test="true()">
	Element 'ram:QuotationReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:RequisitionerReferencedDocument">
      <report test="true()">
	Element 'ram:RequisitionerReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:SellerOrderReferencedDocument">
      <report test="true()">
	Element 'ram:SellerOrderReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeAgreement/ram:UltimateCustomerOrderReferencedDocument">
      <report test="true()">
	Element 'ram:UltimateCustomerOrderReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery">
      <assert test="count(ram:BilledQuantity)=1">
	Das Element 'ram:BilledQuantity' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:ActualDeliverySupplyChainEvent">
      <report test="true()">
	Element 'ram:ActualDeliverySupplyChainEvent' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:ActualDespatchSupplyChainEvent">
      <report test="true()">
	Element 'ram:ActualDespatchSupplyChainEvent' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:ActualPickUpSupplyChainEvent">
      <report test="true()">
	Element 'ram:ActualPickUpSupplyChainEvent' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:ActualReceiptSupplyChainEvent">
      <report test="true()">
	Element 'ram:ActualReceiptSupplyChainEvent' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:AdditionalReferencedDocument">
      <report test="true()">
	Element 'ram:AdditionalReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:BilledQuantity">
      <assert test="@unitCode">
	Das Attribut '@unitCode' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:BilledQuantity[@unitCodeListAgencyID]">
      <report test="true()">
	Attribut '@unitCodeListAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:BilledQuantity[@unitCodeListAgencyName]">
      <report test="true()">
	Attribut '@unitCodeListAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:BilledQuantity[@unitCodeListID]">
      <report test="true()">
	Attribut '@unitCodeListID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:BilledQuantity[@unitCode]">
      <let name="codeValue7" value="@unitCode"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=7]/enumeration[@value=$codeValue7]">
	Wert von '@unitCode' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:ChargeFreeQuantity">
      <report test="true()">
	Element 'ram:ChargeFreeQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:ConsumptionReportReferencedDocument">
      <report test="true()">
	Element 'ram:ConsumptionReportReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:DeliveryNoteReferencedDocument">
      <report test="true()">
	Element 'ram:DeliveryNoteReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:DespatchAdviceReferencedDocument">
      <report test="true()">
	Element 'ram:DespatchAdviceReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:DespatchedQuantity">
      <report test="true()">
	Element 'ram:DespatchedQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:GrossWeightMeasure">
      <report test="true()">
	Element 'ram:GrossWeightMeasure' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:IncludedSupplyChainPackaging">
      <report test="true()">
	Element 'ram:IncludedSupplyChainPackaging' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:NetWeightMeasure">
      <report test="true()">
	Element 'ram:NetWeightMeasure' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:PackageQuantity">
      <report test="true()">
	Element 'ram:PackageQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:PackingListReferencedDocument">
      <report test="true()">
	Element 'ram:PackingListReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:PerPackageUnitQuantity">
      <report test="true()">
	Element 'ram:PerPackageUnitQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:ProductUnitQuantity">
      <report test="true()">
	Element 'ram:ProductUnitQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:ReceivedQuantity">
      <report test="true()">
	Element 'ram:ReceivedQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:ReceivingAdviceReferencedDocument">
      <report test="true()">
	Element 'ram:ReceivingAdviceReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:RelatedSupplyChainConsignment">
      <report test="true()">
	Element 'ram:RelatedSupplyChainConsignment' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:RequestedDeliverySupplyChainEvent">
      <report test="true()">
	Element 'ram:RequestedDeliverySupplyChainEvent' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:RequestedQuantity">
      <report test="true()">
	Element 'ram:RequestedQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:ShipFromTradeParty">
      <report test="true()">
	Element 'ram:ShipFromTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:ShipToTradeParty">
      <report test="true()">
	Element 'ram:ShipToTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:SpecifiedDeliveryAdjustment">
      <report test="true()">
	Element 'ram:SpecifiedDeliveryAdjustment' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:TheoreticalWeightMeasure">
      <report test="true()">
	Element 'ram:TheoreticalWeightMeasure' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeDelivery/ram:UltimateShipToTradeParty">
      <report test="true()">
	Element 'ram:UltimateShipToTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement">
      <assert test="count(ram:ApplicableTradeTax)=1">
	Das Element 'ram:ApplicableTradeTax' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:SpecifiedTradeSettlementLineMonetarySummation)=1">
	Das Element 'ram:SpecifiedTradeSettlementLineMonetarySummation' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:AdditionalReferencedDocument)&lt;=1">
	Das Element 'ram:AdditionalReferencedDocument' darf höchstens 1 mal auftreten.</assert>
      <assert test="count(ram:ReceivableSpecifiedTradeAccountingAccount)&lt;=1">
	Das Element 'ram:ReceivableSpecifiedTradeAccountingAccount' darf höchstens 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument">
      <assert test="count(ram:TypeCode)=1">
	Das Element 'ram:TypeCode' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:AttachedSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:AttachedSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:AttachmentBinaryObject">
      <report test="true()">
	Element 'ram:AttachmentBinaryObject' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:CopyIndicator">
      <report test="true()">
	Element 'ram:CopyIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:EffectiveSpecifiedPeriod">
      <report test="true()">
	Element 'ram:EffectiveSpecifiedPeriod' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:FormattedIssueDateTime">
      <report test="true()">
	Element 'ram:FormattedIssueDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:GlobalID">
      <report test="true()">
	Element 'ram:GlobalID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:Information">
      <report test="true()">
	Element 'ram:Information' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:IssuerAssignedID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:IssuerTradeParty">
      <report test="true()">
	Element 'ram:IssuerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:LineID">
      <report test="true()">
	Element 'ram:LineID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:PreviousRevisionID">
      <report test="true()">
	Element 'ram:PreviousRevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:ReferenceTypeCode[@name]">
      <report test="true()">
	Attribut '@name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:RevisionID">
      <report test="true()">
	Element 'ram:RevisionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:SectionName">
      <report test="true()">
	Element 'ram:SectionName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:StatusCode">
      <report test="true()">
	Element 'ram:StatusCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:TypeCode">
      <let name="codeValue9" value="."/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=9]/enumeration[@value=$codeValue9]">
	Wert von 'ram:TypeCode' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:TypeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:TypeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:TypeCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:TypeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:TypeCode[@name]">
      <report test="true()">
	Attribut '@name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:AdditionalReferencedDocument/ram:URIID">
      <report test="true()">
	Element 'ram:URIID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax">
      <assert test="count(ram:TypeCode)=1">
	Das Element 'ram:TypeCode' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:CategoryCode)=1">
	Das Element 'ram:CategoryCode' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:AllowanceChargeBasisAmount">
      <report test="true()">
	Element 'ram:AllowanceChargeBasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:BasisAmount">
      <report test="true()">
	Element 'ram:BasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:BasisQuantity">
      <report test="true()">
	Element 'ram:BasisQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:BuyerDeductibleTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:BuyerDeductibleTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:BuyerNonDeductibleTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:BuyerNonDeductibleTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:BuyerRepayableTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:BuyerRepayableTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:CalculatedAmount">
      <report test="true()">
	Element 'ram:CalculatedAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:CalculatedRate">
      <report test="true()">
	Element 'ram:CalculatedRate' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:CalculationSequenceNumeric">
      <report test="true()">
	Element 'ram:CalculationSequenceNumeric' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode">
      <let name="codeValue8" value="."/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=8]/enumeration[@value=$codeValue8]">
	Wert von 'ram:CategoryCode' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:CategoryCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:CategoryName">
      <report test="true()">
	Element 'ram:CategoryName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:CurrencyCode">
      <report test="true()">
	Element 'ram:CurrencyCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:CustomsDutyIndicator">
      <report test="true()">
	Element 'ram:CustomsDutyIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:DueDateTypeCode">
      <report test="true()">
	Element 'ram:DueDateTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReason">
      <report test="true()">
	Element 'ram:ExemptionReason' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:ExemptionReasonCode">
      <report test="true()">
	Element 'ram:ExemptionReasonCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:InformationAmount">
      <report test="true()">
	Element 'ram:InformationAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:Jurisdiction">
      <report test="true()">
	Element 'ram:Jurisdiction' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:LineTotalBasisAmount">
      <report test="true()">
	Element 'ram:LineTotalBasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:PlaceApplicableTradeLocation">
      <report test="true()">
	Element 'ram:PlaceApplicableTradeLocation' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:RateApplicablePercent[@format]">
      <report test="true()">
	Attribut '@format' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:SellerPayableTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:SellerPayableTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:SellerRefundableTaxSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:SellerRefundableTaxSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:ServiceSupplyTradeCountry">
      <report test="true()">
	Element 'ram:ServiceSupplyTradeCountry' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:SpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:SpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:TaxBasisAllowanceRate">
      <report test="true()">
	Element 'ram:TaxBasisAllowanceRate' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:TaxPointDate">
      <report test="true()">
	Element 'ram:TaxPointDate' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:Type">
      <report test="true()">
	Element 'ram:Type' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:TypeCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:TypeCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:TypeCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:TypeCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ApplicableTradeTax/ram:UnitBasisAmount">
      <report test="true()">
	Element 'ram:UnitBasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:CompleteDateTime">
      <report test="true()">
	Element 'ram:CompleteDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:ContinuousIndicator">
      <report test="true()">
	Element 'ram:ContinuousIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:Description">
      <report test="true()">
	Element 'ram:Description' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:DurationMeasure">
      <report test="true()">
	Element 'ram:DurationMeasure' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:EndDateTime/udt:DateTime">
      <report test="true()">
	Element 'udt:DateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:EndDateTime/udt:DateTimeString">
      <assert test="@format">
	Das Attribut '@format' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:EndDateTime/udt:DateTimeString[@format]">
      <let name="codeValue2" value="@format"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=2]/enumeration[@value=$codeValue2]">
	Wert von '@format' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:InclusiveIndicator">
      <report test="true()">
	Element 'ram:InclusiveIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:OpenIndicator">
      <report test="true()">
	Element 'ram:OpenIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:PurposeCode">
      <report test="true()">
	Element 'ram:PurposeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:SeasonCode">
      <report test="true()">
	Element 'ram:SeasonCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:SequenceNumeric">
      <report test="true()">
	Element 'ram:SequenceNumeric' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:StartDateFlexibilityCode">
      <report test="true()">
	Element 'ram:StartDateFlexibilityCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:StartDateTime/udt:DateTime">
      <report test="true()">
	Element 'udt:DateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:StartDateTime/udt:DateTimeString">
      <assert test="@format">
	Das Attribut '@format' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:BillingSpecifiedPeriod/ram:StartDateTime/udt:DateTimeString[@format]">
      <let name="codeValue2" value="@format"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=2]/enumeration[@value=$codeValue2]">
	Wert von '@format' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:DiscountIndicator">
      <report test="true()">
	Element 'ram:DiscountIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:InvoiceIssuerReference">
      <report test="true()">
	Element 'ram:InvoiceIssuerReference' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:InvoiceReferencedDocument">
      <report test="true()">
	Element 'ram:InvoiceReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:PayableSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:PayableSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:PaymentReference">
      <report test="true()">
	Element 'ram:PaymentReference' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:PurchaseSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:PurchaseSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:AmountTypeCode">
      <report test="true()">
	Element 'ram:AmountTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:CostReferenceDimensionPattern">
      <report test="true()">
	Element 'ram:CostReferenceDimensionPattern' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:SetTriggerCode">
      <report test="true()">
	Element 'ram:SetTriggerCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:ReceivableSpecifiedTradeAccountingAccount/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SalesSpecifiedTradeAccountingAccount">
      <report test="true()">
	Element 'ram:SalesSpecifiedTradeAccountingAccount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedFinancialAdjustment">
      <report test="true()">
	Element 'ram:SpecifiedFinancialAdjustment' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedLogisticsServiceCharge">
      <report test="true()">
	Element 'ram:SpecifiedLogisticsServiceCharge' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge">
      <assert test="count(ram:ActualAmount)=1">
	Das Element 'ram:ActualAmount' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ActualAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ActualAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ActualTradeCurrencyExchange">
      <report test="true()">
	Element 'ram:ActualTradeCurrencyExchange' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:BasisAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:BasisAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:BasisQuantity">
      <report test="true()">
	Element 'ram:BasisQuantity' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CalculationPercent[@format]">
      <report test="true()">
	Attribut '@format' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:CategoryTradeTax">
      <report test="true()">
	Element 'ram:CategoryTradeTax' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ChargeIndicator/udt:IndicatorString">
      <report test="true()">
	Element 'udt:IndicatorString' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:PrepaidIndicator">
      <report test="true()">
	Element 'ram:PrepaidIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ReasonCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ReasonCode[@listID]">
      <report test="true()">
	Attribut '@listID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ReasonCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:ReasonCode[@listVersionID]">
      <report test="true()">
	Attribut '@listVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:Reason[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:Reason[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:SequenceNumeric">
      <report test="true()">
	Element 'ram:SequenceNumeric' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeAllowanceCharge/ram:UnitBasisAmount">
      <report test="true()">
	Element 'ram:UnitBasisAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradePaymentTerms">
      <report test="true()">
	Element 'ram:SpecifiedTradePaymentTerms' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementFinancialCard">
      <report test="true()">
	Element 'ram:SpecifiedTradeSettlementFinancialCard' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation">
      <assert test="count(ram:LineTotalAmount)=1">
	Das Element 'ram:LineTotalAmount' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:AllowanceTotalAmount">
      <report test="true()">
	Element 'ram:AllowanceTotalAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:ChargeTotalAmount">
      <report test="true()">
	Element 'ram:ChargeTotalAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:GrandTotalAmount">
      <report test="true()">
	Element 'ram:GrandTotalAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:GrossLineTotalAmount">
      <report test="true()">
	Element 'ram:GrossLineTotalAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:InformationAmount">
      <report test="true()">
	Element 'ram:InformationAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount[@currencyCodeListVersionID]">
      <report test="true()">
	Attribut '@currencyCodeListVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:LineTotalAmount[@currencyID]">
      <report test="true()">
	Attribut '@currencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:NetIncludingTaxesLineTotalAmount">
      <report test="true()">
	Element 'ram:NetIncludingTaxesLineTotalAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:NetLineTotalAmount">
      <report test="true()">
	Element 'ram:NetLineTotalAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:ProductWeightLossInformationAmount">
      <report test="true()">
	Element 'ram:ProductWeightLossInformationAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:TaxBasisTotalAmount">
      <report test="true()">
	Element 'ram:TaxBasisTotalAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:TaxTotalAmount">
      <report test="true()">
	Element 'ram:TaxTotalAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:TotalAllowanceChargeAmount">
      <report test="true()">
	Element 'ram:TotalAllowanceChargeAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SpecifiedTradeSettlementLineMonetarySummation/ram:TotalRetailValueInformationAmount">
      <report test="true()">
	Element 'ram:TotalRetailValueInformationAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:SubtotalCalculatedTradeTax">
      <report test="true()">
	Element 'ram:SubtotalCalculatedTradeTax' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedLineTradeSettlement/ram:TotalAdjustmentAmount">
      <report test="true()">
	Element 'ram:TotalAdjustmentAmount' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct">
      <assert test="count(ram:Name)=1">
	Das Element 'ram:Name' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:AdditionalReferenceReferencedDocument">
      <report test="true()">
	Element 'ram:AdditionalReferenceReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableMaterialGoodsCharacteristic">
      <report test="true()">
	Element 'ram:ApplicableMaterialGoodsCharacteristic' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic">
      <assert test="count(ram:Description)=1">
	Das Element 'ram:Description' muss genau 1 mal auftreten.</assert>
      <assert test="count(ram:Value)=1">
	Das Element 'ram:Value' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:ApplicableProductCharacteristicCondition">
      <report test="true()">
	Element 'ram:ApplicableProductCharacteristicCondition' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:ApplicableReferencedStandard">
      <report test="true()">
	Element 'ram:ApplicableReferencedStandard' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:ContentTypeCode">
      <report test="true()">
	Element 'ram:ContentTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:Description[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:Description[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:MeasurementMethodCode">
      <report test="true()">
	Element 'ram:MeasurementMethodCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:ValueCode">
      <report test="true()">
	Element 'ram:ValueCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:ValueDateTime">
      <report test="true()">
	Element 'ram:ValueDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:ValueIndicator">
      <report test="true()">
	Element 'ram:ValueIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:ValueMeasure">
      <report test="true()">
	Element 'ram:ValueMeasure' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:ValueSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:ValueSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:Value[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ApplicableProductCharacteristic/ram:Value[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:AreaDensityMeasure">
      <report test="true()">
	Element 'ram:AreaDensityMeasure' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:BrandName">
      <report test="true()">
	Element 'ram:BrandName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:BrandOwnerTradeParty">
      <report test="true()">
	Element 'ram:BrandOwnerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:BuyerAssignedID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:BuyerAssignedID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:BuyerAssignedID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:BuyerAssignedID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:BuyerAssignedID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:BuyerAssignedID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:BuyerAssignedID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:CertificationEvidenceReferenceReferencedDocument">
      <report test="true()">
	Element 'ram:CertificationEvidenceReferenceReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ColourCode">
      <report test="true()">
	Element 'ram:ColourCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ColourDescription">
      <report test="true()">
	Element 'ram:ColourDescription' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:Description[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:Description[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification">
      <assert test="count(ram:ClassCode)=1">
	Das Element 'ram:ClassCode' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ApplicableReferencedStandard">
      <report test="true()">
	Element 'ram:ApplicableReferencedStandard' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ClassCode">
      <let name="codeValue5" value="."/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=5]/enumeration[@value=$codeValue5]">
	Wert von 'ram:ClassCode' ist unzulässig.</assert>
      <assert test="@listID">
	Das Attribut '@listID' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ClassCode[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ClassCode[@listAgencyID]">
      <report test="true()">
	Attribut '@listAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ClassCode[@listAgencyName]">
      <report test="true()">
	Attribut '@listAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ClassCode[@listID]">
      <let name="codeValue6" value="@listID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=6]/enumeration[@value=$codeValue6]">
	Wert von '@listID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ClassCode[@listName]">
      <report test="true()">
	Attribut '@listName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ClassCode[@listSchemeURI]">
      <report test="true()">
	Attribut '@listSchemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ClassCode[@listURI]">
      <report test="true()">
	Attribut '@listURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ClassCode[@name]">
      <report test="true()">
	Attribut '@name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ClassName">
      <report test="true()">
	Element 'ram:ClassName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:ClassProductCharacteristic">
      <report test="true()">
	Element 'ram:ClassProductCharacteristic' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:SubClassCode">
      <report test="true()">
	Element 'ram:SubClassCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:SystemID">
      <report test="true()">
	Element 'ram:SystemID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DesignatedProductClassification/ram:SystemName">
      <report test="true()">
	Element 'ram:SystemName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:Designation">
      <report test="true()">
	Element 'ram:Designation' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:DrainedNetWeightMeasure">
      <report test="true()">
	Element 'ram:DrainedNetWeightMeasure' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:EndItemName">
      <report test="true()">
	Element 'ram:EndItemName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:EndItemTypeCode">
      <report test="true()">
	Element 'ram:EndItemTypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:FormattedCancellationAnnouncedLaunchDateTime">
      <report test="true()">
	Element 'ram:FormattedCancellationAnnouncedLaunchDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:FormattedLatestProductDataChangeDateTime">
      <report test="true()">
	Element 'ram:FormattedLatestProductDataChangeDateTime' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:GlobalID">
      <assert test="@schemeID">
	Das Attribut '@schemeID' ist erforderlich in diesem Kontext.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:GlobalID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:GlobalID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:GlobalID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:GlobalID[@schemeID]">
      <let name="codeValue4" value="@schemeID"/>
      <assert test="document(&apos;zugferd2p0_en16931_codedb.xml&apos;)//cl[@id=4]/enumeration[@value=$codeValue4]">
	Wert von '@schemeID' ist unzulässig.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:GlobalID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:GlobalID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:GlobalID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:GrossWeightMeasure">
      <report test="true()">
	Element 'ram:GrossWeightMeasure' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ID">
      <report test="true()">
	Element 'ram:ID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:IncludedReferencedProduct">
      <report test="true()">
	Element 'ram:IncludedReferencedProduct' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:IndividualTradeProductInstance">
      <report test="true()">
	Element 'ram:IndividualTradeProductInstance' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:InformationNote">
      <report test="true()">
	Element 'ram:InformationNote' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:InspectionReferenceReferencedDocument">
      <report test="true()">
	Element 'ram:InspectionReferenceReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:LegalRightsOwnerTradeParty">
      <report test="true()">
	Element 'ram:LegalRightsOwnerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:LinearSpatialDimension">
      <report test="true()">
	Element 'ram:LinearSpatialDimension' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:MSDSReferenceReferencedDocument">
      <report test="true()">
	Element 'ram:MSDSReferenceReferencedDocument' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ManufacturerAssignedID">
      <report test="true()">
	Element 'ram:ManufacturerAssignedID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ManufacturerTradeParty">
      <report test="true()">
	Element 'ram:ManufacturerTradeParty' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:MaximumLinearSpatialDimension">
      <report test="true()">
	Element 'ram:MaximumLinearSpatialDimension' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:MinimumLinearSpatialDimension">
      <report test="true()">
	Element 'ram:MinimumLinearSpatialDimension' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:Name[@languageID]">
      <report test="true()">
	Attribut '@languageID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:Name[@languageLocaleID]">
      <report test="true()">
	Attribut '@languageLocaleID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:NetWeightMeasure">
      <report test="true()">
	Element 'ram:NetWeightMeasure' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:OriginTradeCountry">
      <assert test="count(ram:ID)=1">
	Das Element 'ram:ID' muss genau 1 mal auftreten.</assert>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:OriginTradeCountry/ram:ID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:OriginTradeCountry/ram:ID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:OriginTradeCountry/ram:ID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:OriginTradeCountry/ram:Name">
      <report test="true()">
	Element 'ram:Name' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:OriginTradeCountry/ram:SubordinateTradeCountrySubDivision">
      <report test="true()">
	Element 'ram:SubordinateTradeCountrySubDivision' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:PresentationSpecifiedBinaryFile">
      <report test="true()">
	Element 'ram:PresentationSpecifiedBinaryFile' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:ProductGroupID">
      <report test="true()">
	Element 'ram:ProductGroupID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:SellerAssignedID[@schemeAgencyID]">
      <report test="true()">
	Attribut '@schemeAgencyID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:SellerAssignedID[@schemeAgencyName]">
      <report test="true()">
	Attribut '@schemeAgencyName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:SellerAssignedID[@schemeDataURI]">
      <report test="true()">
	Attribut '@schemeDataURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:SellerAssignedID[@schemeID]">
      <report test="true()">
	Attribut '@schemeID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:SellerAssignedID[@schemeName]">
      <report test="true()">
	Attribut '@schemeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:SellerAssignedID[@schemeURI]">
      <report test="true()">
	Attribut '@schemeURI' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:SellerAssignedID[@schemeVersionID]">
      <report test="true()">
	Attribut '@schemeVersionID' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:SubBrandName">
      <report test="true()">
	Element 'ram:SubBrandName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:TradeName">
      <report test="true()">
	Element 'ram:TradeName' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:TypeCode">
      <report test="true()">
	Element 'ram:TypeCode' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:UseDescription">
      <report test="true()">
	Element 'ram:UseDescription' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:SupplyChainTradeTransaction/ram:IncludedSupplyChainTradeLineItem/ram:SpecifiedTradeProduct/ram:VariableMeasureIndicator">
      <report test="true()">
	Element 'ram:VariableMeasureIndicator' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
  <pattern>
    <rule context="/rsm:CrossIndustryInvoice/rsm:ValuationBreakdownStatement">
      <report test="true()">
	Element 'rsm:ValuationBreakdownStatement' soll in diesem Kontext nicht verwendet werden.</report>
    </rule>
  </pattern>
</schema>
