Class {
	#name : 'LxxCountrySubdivisionsLoader',
	#superclass : 'LcsObjectsLoader',
	#category : 'Lcs-PrototypeSystem-Core',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Core'
}

{ #category : 'private' }
LxxCountrySubdivisionsLoader >> collectionSize [
	| stream numberOfLines|
	numberOfLines := 0.
	stream := self data readStream.
	[ stream atEnd ] whileFalse: [
		stream nextLine.
		numberOfLines := numberOfLines + 1 ].
	^numberOfLines
	
]

{ #category : 'loading' }
LxxCountrySubdivisionsLoader >> load: aDatum for: aTargetClass into: aTargetCollection [
	self
		loadFrom: aDatum readStream
		class: aTargetClass
		into: aTargetCollection
]

{ #category : 'loading' }
LxxCountrySubdivisionsLoader >> loadFrom: aDataStream class: aTargetClass into: aTargetCollection [
	| newDomainObject | 
	[ aDataStream atEnd ] whileFalse: [
		newDomainObject := aTargetClass new.
		self populate: newDomainObject with: aDataStream nextLine.
		aTargetCollection add: newDomainObject ] 
]

{ #category : 'loading' }
LxxCountrySubdivisionsLoader >> loadInto: aTargetCollection [
	self shouldNotImplement
]

{ #category : 'schema' }
LxxCountrySubdivisionsLoader >> schema [
	^#( 'isoCode' 'formalName' 'subdivisionName' )
]
