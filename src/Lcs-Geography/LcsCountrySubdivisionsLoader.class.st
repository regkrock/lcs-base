Class {
	#name : 'LcsCountrySubdivisionsLoader',
	#superclass : 'LcsObjectsLoader',
	#category : 'Lcs-Geography-Domain',
	#package : 'Lcs-Geography',
	#tag : 'Domain'
}

{ #category : 'private' }
LcsCountrySubdivisionsLoader >> collectionSize [
	| stream numberOfLines|
	numberOfLines := 0.
	stream := self data readStream.
	[ stream atEnd ] whileFalse: [
		stream nextLine.
		numberOfLines := numberOfLines + 1 ].
	^numberOfLines
	
]

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
