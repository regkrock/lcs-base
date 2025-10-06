Class {
	#name : #LcsCountries,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-Geography-Domain'
}

{ #category : #query }
LcsCountries >> defaultInstance [
	^ self collection detect: [ :each | each class = LcsUnknownCountry ] ifNone: [ LcsUnknownCountry new ]
]
