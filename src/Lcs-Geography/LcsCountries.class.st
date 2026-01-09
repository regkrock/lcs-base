Class {
	#name : 'LcsCountries',
	#superclass : 'LcsDomainCollection',
	#instVars : [
		'unknownInstance'
	],
	#category : 'Lcs-Geography-Domain',
	#package : 'Lcs-Geography',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsCountries class >> unknownInstanceSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUnknownInstanceSlot new
			addSlotType: LcsUnknownCountry;
			addPostUpdateAction: (
				LcsUpdateAction new
					description: 'Add the unknown instance to the collection';
					actionBlock: [ :value :parentDomainObject :oldValue | parentDomainObject add: value ];
					yourself);
			yourself
]

{ #category : 'query' }
LcsCountries >> defaultInstance [
	^ self unknownInstance
]

{ #category : 'query' }
LcsCountries >> findItemMatchingCode: aCode [
	^ self findItemMatchingCode: aCode ifNone: [ nil ]
]

{ #category : 'query' }
LcsCountries >> findItemMatchingCode: aCode ifNone: aBlock [
	^ self
		find: [ :each | each isoCode = aCode ]
		ifNone: aBlock
]

{ #category : 'query' }
LcsCountries >> findItemMatchingCodeOrName: anIsoCodeOrName [
	^ self findItemMatchingCodeOrName: anIsoCodeOrName ifNone: [ nil ]
]

{ #category : 'query' }
LcsCountries >> findItemMatchingCodeOrName: anIsoCodeOrName ifNone: aBlock [
	^ self
		find: [ :eachCountry | 
			eachCountry isoCode = anIsoCodeOrName
				or: [ eachCountry isoCode3 = anIsoCodeOrName
						or: [ eachCountry commonName = anIsoCodeOrName ] ] ]
		ifNone: aBlock
]

{ #category : 'accessing' }
LcsCountries >> unknownInstance [
	^ self slotVarNamed: 'unknownInstance'
]

{ #category : 'accessing' }
LcsCountries >> unknownInstance: anObject [
	self slotVarNamed: 'unknownInstance' put: anObject
]
