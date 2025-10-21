Class {
	#name : #LcsCountries,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-Geography-Domain'
}

{ #category : #query }
LcsCountries >> defaultInstance [
	^ self 
		find: [ :each | each class = LcsUnknownCountry ]
		ifNone: [ LcsUnknownCountry new ]
]

{ #category : #query }
LcsCountries >> findItemMatchingString: anObject [
	anObject isString ifFalse: [ ^ anObject ].
	^ self collection detect: [ :eachCountry | 
		eachCountry isoCode = anObject or: [ 
			eachCountry isoCode3 = anObject or: [ 
			eachCountry commonName = anObject] ] ] ifNone: [ anObject ]
]
