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
LcsCountries >> findItemMatchingCode: anObject [
	| result |
	anObject isString ifFalse: [ ^ anObject ].
	result := self collection
			detect: [ :eachCountry | 
				eachCountry isoCode = anObject
					or: [ eachCountry isoCode3 = anObject or: [ eachCountry commonName = anObject ] ] ]
			ifNone: [ nil ].
	result ifNotNil: [ ^ result ].
	^ self pendingAdds
		detect: [ :eachCountry | 
			eachCountry isoCode = anObject
				or: [ eachCountry isoCode3 = anObject or: [ eachCountry commonName = anObject ] ] ]
		ifNone: [ nil ]
]
