Class {
	#name : 'GtLepiterDefinition',
	#superclass : 'IceDefinition',
	#category : 'GToolkit4Git-Lepiter',
	#package : 'GToolkit4Git',
	#tag : 'Lepiter'
}

{ #category : 'accessing' }
GtLepiterDefinition >> canBeBrowsed [
	^ false
]

{ #category : 'accessing' }
GtLepiterDefinition >> needsRepositoryForTool [
	^ true
]

{ #category : 'accessing' }
GtLepiterDefinition >> removeFrom: anObject [
	"noop"
]
