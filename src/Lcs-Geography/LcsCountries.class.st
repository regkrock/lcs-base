Class {
	#name : #LcsCountries,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-Geography-Domain'
}

{ #category : #query }
LcsCountries >> defaultInstance [
	| defaultCountry |
	defaultCountry := self collection detect: [ :each | each class = LcsUnknownCountry ] ifNone: [ nil ].
	defaultCountry notNil ifTrue: [ ^ defaultCountry ].
	defaultCountry := self pendingAdds detect: [ :each | each class = LcsUnknownCountry ] ifNone: [ nil ].
	defaultCountry notNil ifTrue: [ ^ defaultCountry ].
	^ LcsUnknownCountry new
]

{ #category : #query }
LcsCountries >> findItemMatchingString: anObject [
	anObject isString ifFalse: [ ^ anObject ].
	^ self collection detect: [ :eachCountry | 
		eachCountry isoCode = anObject or: [ 
			eachCountry isoCode3 = anObject or: [ 
			eachCountry commonName = anObject] ] ] ifNone: [ anObject ]
]
