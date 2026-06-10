Class {
	#name : 'LcsCountrySubdivisionsLoader',
	#superclass : 'LcsObjectsLoader',
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'loading' }
LcsCountrySubdivisionsLoader >> load: aDatum for: aTargetClass into: aTargetCollection [
	self
		loadFrom: aDatum readStream
		class: aTargetClass
		into: aTargetCollection
]

{ #category : 'loading' }
LcsCountrySubdivisionsLoader >> loadFrom: aDataStream class: aTargetClass into: aTargetCollection [
	| newDomainObject | 
	[ aDataStream atEnd ] whileFalse: [
		newDomainObject := aTargetClass new.
		self populate: newDomainObject with: aDataStream nextLine.
		aTargetCollection add: newDomainObject ] 
]

{ #category : 'loading' }
LcsCountrySubdivisionsLoader >> loadInto: aTargetCollection [
	self shouldNotImplement
]

{ #category : 'schema' }
LcsCountrySubdivisionsLoader >> schema [
	^#( 'isoCode' 'formalName' 'subdivisionName' )
]
