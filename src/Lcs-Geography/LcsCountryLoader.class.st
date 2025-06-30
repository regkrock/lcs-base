Class {
	#name : #LcsCountryLoader,
	#superclass : #LcsObjectsLoader,
	#instVars : [
		'schemaSetters'
	],
	#category : #'Lcs-Geography-Domain'
}

{ #category : #data }
LcsCountryLoader >> caSubdivisionData [
	^'NL	Newfoundland And Labrador	Province
PE	Prince Edward Island	Province
NU	Nunavat	Territory
NB	New Brunswick	Province
NS	Nova Scotia	Province
QC	Quebec	Province
ON	Ontario	Province
MB	Manitoba	Province
SK	Saskatchewan	Province
AB	Alberta	Province
BC	British Columbia	Province
YT	Yukon	Territory
NT	Northwest Territory	Territory'
]

{ #category : #'as yet unclassified' }
LcsCountryLoader >> caSubdivisionDataSchema [
	^#( 'code' 'formalName' 'politicalUnit' )
]

{ #category : #'as yet unclassified' }
LcsCountryLoader >> collectionSize [
	| stream numberOfLines|
	numberOfLines := 0.
	stream := self data readStream.
	[ stream atEnd ] whileFalse: [
		stream nextLine.
		numberOfLines := numberOfLines + 1 ].
	^numberOfLines
	
]

{ #category : #data }
LcsCountryLoader >> data [
	^ 'Canada	CA	CAN	124	Canada
United Kingdom of Great Britain and Northern Ireland (the)	GB	GBR	826	United Kingdom
United States of America (the)	US	USA	840	United States'
]

{ #category : #data }
LcsCountryLoader >> dataComplete [
^ 'Afghanistan	AF	AFG	004	Afghanistan
Albania	AL	ALB	008	Albania
Algeria	DZ	DZA	012	Algeria
American Samoa	AS	ASM	016	American Samoa
Andorra	AD	AND	020	Andorra
Angola	AO	AGO	024	Angola
Anguilla	AI	AIA	660	Anguilla
Antarctica	AQ	ATA	010	Antarctica
Antigua and Barbuda	AG	ATG	028	Antigua and Barbuda
Argentina	AR	ARG	032	Argentina
Armenia	AM	ARM	051	Armenia
Aruba	AW	ABW	533	Aruba
Australia	AU	AUS	036	Australia
Austria	AT	AUT	040	Austria
Azerbaijan	AZ	AZE	031	Azerbaijan
Bahamas (the)	BS	BHS	044	Bahamas (the)
Bahrain	BH	BHR	048	Bahrain
Bangladesh	BD	BGD	050	Bangladesh
Barbados	BB	BRB	052	Barbados
Belarus	BY	BLR	112	Belarus
Belgium	BE	BEL	056	Belgium
Belize	BZ	BLZ	084	Belize
Benin	BJ	BEN	204	Benin
Bermuda	BM	BMU	060	Bermuda
Bhutan	BT	BTN	064	Bhutan
Bolivia (Plurinational State of)	BO	BOL	068	Bolivia
Bonaire, Sint Eustatius and Saba	BQ	BES	535	Bonaire, Sint Eustatius and Saba
Bosnia and Herzegovina	BA	BIH	070	Bosnia and Herzegovina
Botswana	BW	BWA	072	Botswana
Bouvet Island	BV	BVT	074	Bouvet Island
Brazil	BR	BRA	076	Brazil
British Indian Ocean Territory (the)	IO	IOT	086	British Indian Ocean Territory
Brunei Darussalam	BN	BRN	096	Brunei Darussalam
Bulgaria	BG	BGR	100	Bulgaria
Burkina Faso	BF	BFA	854	Burkina Faso
Burundi	BI	BDI	108	Burundi
Cabo Verde	CV	CPV	132	Cabo Verde
Cambodia	KH	KHM	116	Cambodia
Cameroon	CM	CMR	120	Cameroon
Canada	CA	CAN	124	Canada
Cayman Islands (the)	KY	CYM	136	Cayman Islands
Central African Republic (the)	CF	CAF	140	Central African Republic
Chad	TD	TCD	148	Chad
Chile	CL	CHL	152	Chile
China	CN	CHN	156	China
Christmas Island	CX	CXR	162	Christmas Island
Cocos (Keeling) Islands (the)	CC	CCK	166	Cocos (Keeling) Islands
Colombia	CO	COL	170	Colombia
Comoros (the)	KM	COM	174	Comoros (the)
Congo (the Democratic Republic of the)	CD	COD	180	Democratic Congo
Congo (the)	CG	COG	178	Congo
Cook Islands (the)	CK	COK	184	Cook Islands
Costa Rica	CR	CRI	188	Costa Rica
Croatia	HR	HRV	191	Croatia
Cuba	CU	CUB	192	Cuba
Curaçao	CW	CUW	531	Curaçao
Cyprus	CY	CYP	196	Cyprus
Czechia	CZ	CZE	203	Czechia
Côte d''Ivoire	CI	CIV	384	Côte d''Ivoire
Denmark	DK	DNK	208	Denmark
Djibouti	DJ	DJI	262	Djibouti
Dominica	DM	DMA	212	Dominica
Dominican Republic (the)	DO	DOM	214	Dominican Republic
Ecuador	EC	ECU	218	Ecuador
Egypt	EG	EGY	818	Egypt
El Salvador	SV	SLV	222	El Salvador
Equatorial Guinea	GQ	GNQ	226	Equatorial Guinea
Eritrea	ER	ERI	232	Eritrea
Estonia	EE	EST	233	Estonia
Eswatini	SZ	SWZ	748	Eswatini
Ethiopia	ET	ETH	231	Ethiopia
Falkland Islands (the) [Malvinas]	FK	FLK	238	Falkland Islands
Faroe Islands (the)	FO	FRO	234	Faroe Islands (the)
Fiji	FJ	FJI	242	Fiji
Finland	FI	FIN	246	Finland
France	FR	FRA	250	France
French Guiana	GF	GUF	254	French Guiana
French Polynesia	PF	PYF	258	French Polynesia
French Southern Territories (the)	TF	ATF	260	French Southern Territories
Gabon	GA	GAB	266	Gabon
Gambia (the)	GM	GMB	270	Gambia
Georgia	GE	GEO	268	Georgia
Germany	DE	DEU	276	Germany
Ghana	GH	GHA	288	Ghana
Gibraltar	GI	GIB	292	Gibraltar
Greece	GR	GRC	300	Greece
Greenland	GL	GRL	304	Greenland
Grenada	GD	GRD	308	Grenada
Guadeloupe	GP	GLP	312	Guadeloupe
Guam	GU	GUM	316	Guam
Guatemala	GT	GTM	320	Guatemala
Guernsey	GG	GGY	831	Guernsey
Guinea	GN	GIN	324	Guinea
Guinea-Bissau	GW	GNB	624	Guinea-Bissau
Guyana	GY	GUY	328	Guyana
Haiti	HT	HTI	332	Haiti
Heard Island and McDonald Islands	HM	HMD	334	Heard Island and McDonald Islands
Holy See (the)	VA	VAT	336	Vatican
Honduras	HN	HND	340	Honduras
Hong Kong	HK	HKG	344	Hong Kong
Hungary	HU	HUN	348	Hungary
Iceland	IS	ISL	352	Iceland
India	IN	IND	356	India
Indonesia	ID	IDN	360	Indonesia
Iran (Islamic Republic of)	IR	IRN	364	Iran
Iraq	IQ	IRQ	368	Iraq
Ireland	IE	IRL	372	Ireland
Isle of Man	IM	IMN	833	Isle of Man
Israel	IL	ISR	376	Israel
Italy	IT	ITA	380	Italy
Jamaica	JM	JAM	388	Jamaica
Japan	JP	JPN	392	Japan
Jersey	JE	JEY	832	Jersey
Jordan	JO	JOR	400	Jordan
Kazakhstan	KZ	KAZ	398	Kazakhstan
Kenya	KE	KEN	404	Kenya
Kiribati	KI	KIR	296	Kiribati
Korea (the Democratic People''s Republic of)	KP	PRK	408	North Korea
Korea (the Republic of)	KR	KOR	410	South Korea
Kuwait	KW	KWT	414	Kuwait
Kyrgyzstan	KG	KGZ	417	Kyrgyzstan
Lao People''s Democratic Republic (the)	LA	LAO	418	Laos
Latvia	LV	LVA	428	Latvia
Lebanon	LB	LBN	422	Lebanon
Lesotho	LS	LSO	426	Lesotho
Liberia	LR	LBR	430	Liberia
Libya	LY	LBY	434	Libya
Liechtenstein	LI	LIE	438	Liechtenstein
Lithuania	LT	LTU	440	Lithuania
Luxembourg	LU	LUX	442	Luxembourg
Macao	MO	MAC	446	Macao
Madagascar	MG	MDG	450	Madagascar
Malawi	MW	MWI	454	Malawi
Malaysia	MY	MYS	458	Malaysia
Maldives	MV	MDV	462	Maldives
Mali	ML	MLI	466	Mali
Malta	MT	MLT	470	Malta
Marshall Islands (the)	MH	MHL	584	Marshall Islands (the)
Martinique	MQ	MTQ	474	Martinique
Mauritania	MR	MRT	478	Mauritania
Mauritius	MU	MUS	480	Mauritius
Mayotte	YT	MYT	175	Mayotte
Mexico	MX	MEX	484	Mexico
Micronesia (Federated States of)	FM	FSM	583	Micronesia
Moldova (the Republic of)	MD	MDA	498	Moldova
Monaco	MC	MCO	492	Monaco
Mongolia	MN	MNG	496	Mongolia
Montenegro	ME	MNE	499	Montenegro
Montserrat	MS	MSR	500	Montserrat
Morocco	MA	MAR	504	Morocco
Mozambique	MZ	MOZ	508	Mozambique
Myanmar	MM	MMR	104	Myanmar
Namibia	NA	NAM	516	Namibia
Nauru	NR	NRU	520	Nauru
Nepal	NP	NPL	524	Nepal
Netherlands (the)	NL	NLD	528	Netherlands
New Caledonia	NC	NCL	540	New Caledonia
New Zealand	NZ	NZL	554	New Zealand
Nicaragua	NI	NIC	558	Nicaragua
Niger (the)	NE	NER	562	Niger
Nigeria	NG	NGA	566	Nigeria
Niue	NU	NIU	570	Niue
Norfolk Island	NF	NFK	574	Norfolk Island
Northern Mariana Islands (the)	MP	MNP	580	Northern Mariana Islands
Norway	NO	NOR	578	Norway
Oman	OM	OMN	512	Oman
Pakistan	PK	PAK	586	Pakistan
Palau	PW	PLW	585	Palau
Palestine, State of	PS	PSE	275	Palestine
Panama	PA	PAN	591	Panama
Papua New Guinea	PG	PNG	598	Papua New Guinea
Paraguay	PY	PRY	600	Paraguay
Peru	PE	PER	604	Peru
Philippines (the)	PH	PHL	608	Philippines
Pitcairn	PN	PCN	612	Pitcairn
Poland	PL	POL	616	Poland
Portugal	PT	PRT	620	Portugal
Puerto Rico	PR	PRI	630	Puerto Rico
Qatar	QA	QAT	634	Qatar
Republic of North Macedonia	MK	MKD	807	Republic of North Macedonia
Romania	RO	ROU	642	Romania
Russian Federation (the)	RU	RUS	643	Russian Federation
Rwanda	RW	RWA	646	Rwanda
Réunion	RE	REU	638	Réunion
Saint Barthélemy	BL	BLM	652	Saint Barthélemy
Saint Helena, Ascension and Tristan da Cunha	SH	SHN	654	Saint Helena, Ascension and Tristan da Cunha
Saint Kitts and Nevis	KN	KNA	659	Saint Kitts and Nevis
Saint Lucia	LC	LCA	662	Saint Lucia
Saint Martin (French part)	MF	MAF	663	Saint Martin
Saint Pierre and Miquelon	PM	SPM	666	Saint Pierre and Miquelon
Saint Vincent and the Grenadines	VC	VCT	670	Saint Vincent and the Grenadines
Samoa	WS	WSM	882	Samoa
San Marino	SM	SMR	674	San Marino
Sao Tome and Principe	ST	STP	678	Sao Tome and Principe
Saudi Arabia	SA	SAU	682	Saudi Arabia
Senegal	SN	SEN	686	Senegal
Serbia	RS	SRB	688	Serbia
Seychelles	SC	SYC	690	Seychelles
Sierra Leone	SL	SLE	694	Sierra Leone
Singapore	SG	SGP	702	Singapore
Sint Maarten (Dutch part)	SX	SXM	534	Sint Maarten
Slovakia	SK	SVK	703	Slovakia
Slovenia	SI	SVN	705	Slovenia
Solomon Islands	SB	SLB	090	Solomon Islands
Somalia	SO	SOM	706	Somalia
South Africa	ZA	ZAF	710	South Africa
South Georgia and the South Sandwich Islands	GS	SGS	239	South Georgia and the South Sandwich Islands
South Sudan	SS	SSD	728	South Sudan
Spain	ES	ESP	724	Spain
Sri Lanka	LK	LKA	144	Sri Lanka
Sudan (the)	SD	SDN	729	Sudan
Suriname	SR	SUR	740	Suriname
Svalbard and Jan Mayen	SJ	SJM	744	Svalbard and Jan Mayen
Sweden	SE	SWE	752	Sweden
Switzerland	CH	CHE	756	Switzerland
Syrian Arab Republic	SY	SYR	760	Syrian Arab Republic
Taiwan (Province of China)	TW	TWN	158	Taiwan
Tajikistan	TJ	TJK	762	Tajikistan
Tanzania, United Republic of	TZ	TZA	834	Tanzania
Thailand	TH	THA	764	Thailand
Timor-Leste	TL	TLS	626	Timor-Leste
Togo	TG	TGO	768	Togo
Tokelau	TK	TKL	772	Tokelau
Tonga	TO	TON	776	Tonga
Trinidad and Tobago	TT	TTO	780	Trinidad and Tobago
Tunisia	TN	TUN	788	Tunisia
Turkey	TR	TUR	792	Turkey
Turkmenistan	TM	TKM	795	Turkmenistan
Turks and Caicos Islands (the)	TC	TCA	796	Turks and Caicos Islands
Tuvalu	TV	TUV	798	Tuvalu
Uganda	UG	UGA	800	Uganda
Ukraine	UA	UKR	804	Ukraine
United Arab Emirates (the)	AE	ARE	784	United Arab Emirates
United Kingdom of Great Britain and Northern Ireland (the)	GB	GBR	826	United Kingdom
United States Minor Outlying Islands (the)	UM	UMI	581	United States Minor Outlying Islands
United States of America (the)	US	USA	840	United States
Uruguay	UY	URY	858	Uruguay
Uzbekistan	UZ	UZB	860	Uzbekistan
Vanuatu	VU	VUT	548	Vanuatu
Venezuela (Bolivarian Republic of)	VE	VEN	862	Venezuela
Viet Nam	VN	VNM	704	Viet Nam
Virgin Islands (British)	VG	VGB	092	Virgin Islands (British)
Virgin Islands (U.S.)	VI	VIR	850	Virgin Islands (U.S.)
Wallis and Futuna	WF	WLF	876	Wallis and Futuna
Western Sahara	EH	ESH	732	Western Sahara
Yemen	YE	YEM	887	Yemen
Zambia	ZM	ZMB	894	Zambia
Zimbabwe	ZW	ZWE	716	Zimbabwe
Åland Islands	AX	ALA	248	Åland Islands'
]

{ #category : #initialize }
LcsCountryLoader >> initialize [ 
	super initialize.
	self schemaSetters: (self schema collect: [ :each | (each , ':') asSymbol ])
]

{ #category : #loading }
LcsCountryLoader >> load [
	self loadFrom: self data readStream class: self targetClass schema: self schema
]

{ #category : #loading }
LcsCountryLoader >> loadFrom: aDataStream class: aTargetClass schema: anArray [
	| instance line setters subdivisionSelector | 
	setters := anArray collect: [ :each | (each , ':') asSymbol ].
	[ aDataStream atEnd ] whileFalse: [
		instance := aTargetClass new.
		line := aDataStream nextLine. 
		(line substrings: {Character tab}) doWithIndex: [ :value :index |.
			instance perform: (setters at: index) with: value ].
		subdivisionSelector := (instance isoCode asLowercase , 'SubdivisionData') asSymbol.
		(self respondsTo: subdivisionSelector) ifTrue: [
			self 
				loadSubdivisionsFrom: (self perform:  subdivisionSelector) readStream 
				class: LcsBaseCountrySubdivision 
				schema: self usSubdivisionDataSchema 
				context: instance ] ] 
]

{ #category : #loading }
LcsCountryLoader >> loadSubdivisionsFrom: aDataStream class: aTargetClass schema: anArray context: aCountry [
	| instance line setters | 
	setters := anArray collect: [ :each | (each , ':') asSymbol ].
	[ aDataStream atEnd ] whileFalse: [
		instance := aTargetClass newInContextOf: aCountry.
		line := aDataStream nextLine. 
		(line substrings: {Character tab}) doWithIndex: [ :value :index |.
			instance perform: (setters at: index) with: value ] ] 
]

{ #category : #loading }
LcsCountryLoader >> schema [
	^#( 'formalName' 'isoCode' 'isoCode3' 'isoNumber' 'commonName' )
]

{ #category : #accessing }
LcsCountryLoader >> schemaSetters [
	^ schemaSetters
]

{ #category : #accessing }
LcsCountryLoader >> schemaSetters: anObject [
	schemaSetters := anObject
]

{ #category : #'as yet unclassified' }
LcsCountryLoader >> targetClass [
	^ LcsCountry
]

{ #category : #'as yet unclassified' }
LcsCountryLoader >> usSubdivisionData [
	^'AL	Alabama	State
AK	Alaska	State
AZ	Arizona	State
AR	Arkansas	State
CA	California	State
CO	Colorado	State
CT	Connecticut	State
DE	Delaware	State
FL	Florida	State
GA	Georgia	State
HI	Hawaii	State
ID	Idaho	State
IL	Illinois	State
IN	Indiana	State
IA	Iowa	State
KS	Kansas	State
KY	Kentucky	State
LA	Louisiana	State
ME	Maine	State
MD	Maryland	State
MA	Massachusetts	State
MI	Michigan	State
MN	Minnesota	State
MS	Mississippi	State
MO	Missouri	State
MT	Montana	State
NE	Nebraska	State
NV	Nevada	State
NH	New Hampshire	State
NJ	New Jersey	State
NM	New Mexico	State
NY	New York	State
NC	North Carolina	State
ND	North Dakota	State
OH	Ohio	State
OK	Oklahoma	State
OR	Oregon	State
PA	Pennsylvania	State
RI	Rhode Island	State
SC	South Carolina	State
SD	South Dakota	State
TN	Tennessee	State
TX	Texas	State
UT	Utah	State
VT	Vermont	State
VA	Virginia	State
WA	Washington	State
WV	West Virginia	State
WI	Wisconsin	State
WY	Wyoming	State
DC	District of Columbia	District'
]

{ #category : #'as yet unclassified' }
LcsCountryLoader >> usSubdivisionDataSchema [
	^#( 'isoCode' 'formalName' 'subdivisionName' )
]
