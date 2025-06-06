Class {
	#name : #LcsCodesLoaderClassBuilder,
	#superclass : #LcsLoaderClassBuilder,
	#instVars : [
		'protoCodes'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsCodesLoaderClassBuilder class >> targetSuperclassName [	
	^ 'LcsValueObjectsLoader'
]

{ #category : #build }
LcsCodesLoaderClassBuilder >> dataString [
	^ String streamContents: [ :stream |
		(NeoJSONWriter on: stream)
			mapInstVarsFor: LcsProtoCode;
			nextPut: self protoCodes ].
]

{ #category : #accessing }
LcsCodesLoaderClassBuilder >> protoCodes [
	^ protoCodes
]

{ #category : #accessing }
LcsCodesLoaderClassBuilder >> protoCodes: anObject [
	protoCodes := anObject
]
