Class {
	#name : #LcsStandardCodeClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'codeInstances'
	],
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> codeInstances [
	^ codeInstances
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> codeInstances: aCollection [
	codeInstances := aCollection
]

{ #category : #configuration }
LcsStandardCodeClassesBuilderJob >> codeSuperclassRootName: aString [ 
	self codeSuperclassBuilder rootName: aString.
	self memberOfSlotBuilder slotName: ((aString first asLowercase asString) , (aString copyFrom: 2 to: aString size))
]

{ #category : #tests }
LcsStandardCodeClassesBuilderJob >> createCodeInstances: aCollection [ 
	self codeInstances addAll: aCollection
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> initialize [
	self halt.
	super initialize.
	self codeInstances: OrderedCollection new
]
