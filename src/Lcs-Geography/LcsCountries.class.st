Class {
	#name : 'LcsCountries',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-Geography-Domain',
	#package : 'Lcs-Geography',
	#tag : 'Domain'
}

{ #category : 'query' }
LcsCountries >> defaultInstance [
	^ self 
		find: [ :each | each class = LcsUnknownCountry ]
		ifNone: [ LcsUnknownCountry new ]
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
