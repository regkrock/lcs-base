Class {
	#name : #LcsSlotDefinitions,
	#superclass : #LcsObject,
	#instVars : [
		'slotDefinitions',
		'domainClass'
	],
	#category : #LcsBase
}

{ #category : #'instance creation' }
LcsSlotDefinitions class >> newOn: aDomainClass [

	^ self new 
		initializeOn: aDomainClass;
		yourself
]

{ #category : #slots }
LcsSlotDefinitions >> addSlotDefinition: anLcsSlotDefinition [

	anLcsSlotDefinition parent: self.
	self slotDefinitions at: anLcsSlotDefinition slotName put: anLcsSlotDefinition
]

{ #category : #accessing }
LcsSlotDefinitions >> domainClass [
	^ domainClass
]

{ #category : #accessing }
LcsSlotDefinitions >> domainClass: anObject [
	domainClass := anObject
]

{ #category : #testing }
LcsSlotDefinitions >> hasElements [
	^ self slotDefinitions size > 0
]

{ #category : #'testing\t' }
LcsSlotDefinitions >> hasNoElements [
	^self hasElements not
]

{ #category : #accessing }
LcsSlotDefinitions >> initialize [
	super initialize.
	self slotDefinitions: LcsSmalltalkConfiguration symbolDictionaryClass new
]

{ #category : #'model  ' }
LcsSlotDefinitions >> initializeModel: aDomainObject [
	self slotDefinitions values do: [:eachDefintion | eachDefintion initializeModel: aDomainObject]
]

{ #category : #'instance creation' }
LcsSlotDefinitions >> initializeOn: aDomainClass [ 

	self domainClass: aDomainClass
]

{ #category : #accessing }
LcsSlotDefinitions >> slotDefinitionFor: aSlotName [

	^ self slotDefinitions at: aSlotName ifAbsent: [self error: 'no slot defined']
]

{ #category : #accessing }
LcsSlotDefinitions >> slotDefinitionNamed: aSlotName [
	^ self slotDefinitions at: aSlotName ifAbsent: [LcsSlotDoesNotExistError signal: 'Slot not defined: ' , aSlotName asString]
]

{ #category : #accessing }
LcsSlotDefinitions >> slotDefinitions [
	^ slotDefinitions
]

{ #category : #accessing }
LcsSlotDefinitions >> slotDefinitions: anObject [
	slotDefinitions := anObject
]
