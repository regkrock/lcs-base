Class {
	#name : #LcsValueObjectsLoaderClassBuilder,
	#superclass : #LcsLoaderClassBuilder,
	#instVars : [
		'protoCodes'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsValueObjectsLoaderClassBuilder class >> targetSuperclassName [	
	^ 'LcsValueObjectsLoader'
]

{ #category : #build }
LcsValueObjectsLoaderClassBuilder >> dataString [
	^ String streamContents: [ :stream |
		(NeoJSONWriter on: stream)
			mapInstVarsFor: LcsProtoCode;
			nextPut: self protoCodes ].
]

{ #category : #accessing }
LcsValueObjectsLoaderClassBuilder >> protoCodes [
	^ protoCodes
]

{ #category : #accessing }
LcsValueObjectsLoaderClassBuilder >> protoCodes: anObject [
	protoCodes := anObject
]
