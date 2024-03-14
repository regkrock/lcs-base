Class {
	#name : #LcsSlotDefinitions,
	#superclass : #LcsObject,
	#instVars : [
		'elements',
		'domainClass'
	],
	#category : #'Lcs-SlotDefinitions'
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
	self elements at: anLcsSlotDefinition slotName put: anLcsSlotDefinition
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
LcsSlotDefinitions >> elements [
	^ elements
]

{ #category : #accessing }
LcsSlotDefinitions >> elements: anObject [
	elements := anObject
]

{ #category : #testing }
LcsSlotDefinitions >> hasElements [
	^ self elements isNotEmpty
]

{ #category : #testing }
LcsSlotDefinitions >> hasNoElements [
	^ self hasElements not
]

{ #category : #initialization }
LcsSlotDefinitions >> initialize [
	super initialize.
	self elements: LcsSmalltalkConfiguration symbolDictionaryClass new
]

{ #category : #model }
LcsSlotDefinitions >> initializeModel: aDomainObject [
	self elements valuesDo: [ :eachDefintion | eachDefintion initializeModel: aDomainObject ]
]

{ #category : #initialization }
LcsSlotDefinitions >> initializeOn: aDomainClass [ 
	self domainClass: aDomainClass
]

{ #category : #slots }
LcsSlotDefinitions >> slotDefinitionNamed: aSlotName [
	^ self elements at: aSlotName ifAbsent: [ LcsSlotDoesNotExistError signal: 'Slot not defined: ' , aSlotName asString ]
]

{ #category : #validation }
LcsSlotDefinitions >> validateConfiguration [
	self elements valuesDo: [ :eachSlotDefintion | eachSlotDefintion halt validateConfiguration ]
]
