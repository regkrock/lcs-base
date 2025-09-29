Class {
	#name : #LxxCountriesLoader,
	#superclass : #LcsObjectsLoader,
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #data }
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

{ #category : #schema }
LxxCountriesLoader >> caSubdivisionDataSchema [
	^#( 'code' 'formalName' 'politicalUnit' )
]

{ #category : #query }
LxxCountriesLoader >> collectionSize [
	| stream numberOfLines|
	numberOfLines := 0.
	stream := self data readStream.
	[ stream atEnd ] whileFalse: [
		stream nextLine.
		numberOfLines := numberOfLines + 1 ].
	^numberOfLines
	
]

{ #category : #data }
LxxCountriesLoader >> data [
	^ 'Canada	CA	CAN	124	Canada
United Kingdom of Great Britain and Northern Ireland (the)	GB	GBR	826	United Kingdom
United States of America (the)	US	USA	840	United States'
]

{ #category : #loading }
LxxCountriesLoader >> load [
	self loadFrom: self data readStream class: self targetClass schema: self schema
]

{ #category : #loading }
LxxCountriesLoader >> loadFrom: aDataStream class: aTargetClass schema: anArray [
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
				class: LxxBaseCountrySubdivision 
				schema: self usSubdivisionDataSchema 
				context: instance ] ] 
]

{ #category : #loading }
LxxCountriesLoader >> loadSubdivisionsFrom: aDataStream class: aTargetClass schema: anArray context: aCountry [
	| instance line setters | 
	setters := anArray collect: [ :each | (each , ':') asSymbol ].
	[ aDataStream atEnd ] whileFalse: [
		instance := aTargetClass newInContextOf: aCountry.
		line := aDataStream nextLine. 
		(line substrings: {Character tab}) doWithIndex: [ :value :index |.
			instance perform: (setters at: index) with: value ] ] 
]

{ #category : #schema }
LxxCountriesLoader >> schema [
	^#( 'formalName' 'isoCode' 'isoCode3' 'isoNumber' 'commonName' )
]

{ #category : #configuration }
LxxCountriesLoader >> targetClass [
	^ LxxCountry
]

{ #category : #data }
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

{ #category : #schema }
LxxCountriesLoader >> usSubdivisionDataSchema [
	^#( 'isoCode' 'formalName' 'subdivisionName' )
]
