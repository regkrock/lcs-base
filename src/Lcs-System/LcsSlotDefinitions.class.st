Class {
	#name : #LcsSlotDefinitions,
	#superclass : #LcsObject,
	#instVars : [
		'slotDefinitions',
		'domainClass'
	],
	#category : #'Lcs-System'
}

{ #category : #'instance creation' }
LcsSlotDefinitions class >> newOn: aDomainClass [

	^self new 
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

{ #category : #accessing }
LcsSlotDefinitions >> initialize [
	super initialize.
	self slotDefinitions: LcsSmalltalkConfiguration symbolDictionaryClass new
]

{ #category : #'instance creation' }
LcsSlotDefinitions >> initializeOn: aDomainClass [ 

	self domainClass: aDomainClass
]

{ #category : #accessing }
LcsSlotDefinitions >> slotDefinitionFor: aSlotName [

	^self slotDefinitions at: aSlotName ifAbsent: [self error: 'no slot defined']
]

{ #category : #accessing }
LcsSlotDefinitions >> slotDefinitionNamed: aSlotName [
	^self slotDefinitions at: aSlotName ifAbsent: [self error: 'no slot defined']
]

{ #category : #accessing }
LcsSlotDefinitions >> slotDefinitions [
	^ slotDefinitions
]

{ #category : #accessing }
LcsSlotDefinitions >> slotDefinitions: anObject [
	slotDefinitions := anObject
]
