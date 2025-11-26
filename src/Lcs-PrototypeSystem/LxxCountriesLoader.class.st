Class {
	#name : 'LxxCountriesLoader',
	#superclass : 'LcsObjectsLoader',
	#category : 'Lcs-PrototypeSystem-Base',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Base'
}

{ #category : 'data' }
LxxCountriesLoader >> caSubdivisionData [
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

{ #category : 'query' }
LxxCountriesLoader >> collectionSize [
	| stream numberOfLines|
	numberOfLines := 0.
	stream := self data readStream.
	[ stream atEnd ] whileFalse: [
		stream nextLine.
		numberOfLines := numberOfLines + 1 ].
	^numberOfLines
	
]

{ #category : 'data' }
LxxCountriesLoader >> data [
	^ 'Canada	CA	CAN	124	Canada	LxxCanadaPostalCode	LxxCanadaSubdivision	Province
United Kingdom of Great Britain and Northern Ireland (the)	GB	GBR	826	United Kingdom	LxxGenericPostalCode	LxxCountrySubdivision	 
United States of America (the)	US	USA	840	United States	LxxZipCode	LxxUnitedStatesSubdivision	State'
]

{ #category : 'loading' }
LxxCountriesLoader >> loadFrom: aDataStream class: aTargetClass into: aTargetCollection [
	| newDomainObject | 
	[ aDataStream atEnd ] whileFalse: [
		newDomainObject := aTargetClass new.
		self populate: newDomainObject with: aDataStream nextLine.
		aTargetCollection add: newDomainObject.
		self loadSubdivisionsInto: newDomainObject ]
]

{ #category : 'loading' }
LxxCountriesLoader >> loadInto: aTargetCollection [
	self
		loadFrom: self data readStream
		class: self targetClass
		into: aTargetCollection
]

{ #category : 'loading' }
LxxCountriesLoader >> loadSubdivisionsInto: aCountry [
	| selector |
	selector := (aCountry isoCode asLowercase , 'SubdivisionData') asSymbol.
	(self respondsTo: selector)
		ifTrue: [ LxxCountrySubdivisionsLoader new
				load: (self perform: selector)
				for: aCountry subdivisionClass
				into: aCountry subdivisions ]
]

{ #category : 'schema' }
LxxCountriesLoader >> schema [
	^#( 'formalName' 'isoCode' 'isoCode3' 'isoNumber' 'commonName' 'postalCodeClass' 'subdivisionClass' 'subdivisionName')
]

{ #category : 'configuration' }
LxxCountriesLoader >> targetClass [
	^ LxxCountry
]

{ #category : 'data' }
LxxCountriesLoader >> usSubdivisionData [
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
