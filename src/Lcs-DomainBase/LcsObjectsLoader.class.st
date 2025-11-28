Class {
	#name : 'LcsObjectsLoader',
	#superclass : 'LcsObject',
	#instVars : [
		'schemaSetters'
	],
	#category : 'Lcs-DomainBase-Loader',
	#package : 'Lcs-DomainBase',
	#tag : 'Loader'
}

{ #category : 'slot model' }
LcsObjectsLoader class >> initializeSlotModel [ 
	"Not part of the model"
]

{ #category : 'slot model' }
LcsObjectsLoader class >> installSlotDefinitions [ 
	"Not part of the model"
]

{ #category : 'slot model' }
LcsObjectsLoader class >> instantiateSlotModel [ 
	"Not part of the model"
]

{ #category : 'slot model' }
LcsObjectsLoader class >> instantiateSlotModelInSystem: aSystem [
	"Not part of the model"
]

{ #category : 'slot model' }
LcsObjectsLoader class >> verifySlotModelConsistency [
	"Not part of the model"
]

{ #category : 'initialize' }
LcsObjectsLoader >> initialize [ 
	super initialize.
	self schemaSetters: (self schema collect: [ :each | (each , ':') asSymbol ])
]

{ #category : 'loading' }
LcsObjectsLoader >> loadInto: aCollection [
]

{ #category : 'loading' }
LcsObjectsLoader >> populate: aDomainObject with: aLine [
		self schemaSetters with: (aLine substrings: {Character tab}) do: [ :setter :value |
			aDomainObject perform: setter with: value ].
]

{ #category : 'accessing' }
LcsObjectsLoader >> schemaSetters [
	^ schemaSetters
]

{ #category : 'accessing' }
LcsObjectsLoader >> schemaSetters: anObject [
	schemaSetters := anObject
]
