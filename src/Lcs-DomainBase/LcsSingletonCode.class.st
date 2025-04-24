Class {
	#name : #LcsSingletonCode,
	#superclass : #LcsCode,
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #'slot definitions' }
LcsSingletonCode class >> codeSlotDefinition [
	<slotDefinition>
	^ LcsSingletonCodeNameSlot new
]

{ #category : #defaults }
LcsSingletonCode class >> defaultCode [
	self subclassResponsibility
]

{ #category : #defaults }
LcsSingletonCode class >> defaultCodeDescription [
	self subclassResponsibility
]

{ #category : #defaults }
LcsSingletonCode class >> defaultInstance [
	^ false
]

{ #category : #defaults }
LcsSingletonCode class >> defaultShortName [
	self subclassResponsibility
]

{ #category : #'slot definitions' }
LcsSingletonCode class >> descriptionSlotDefinition [
	<slotDefinition>
	^ LcsSingletonCodeDescriptionSlot new
]

{ #category : #'slot definitions' }
LcsSingletonCode class >> isDefaultInstanceSlotDefinition [
	<slotDefinition>
	^ super isDefaultInstanceSlotDefinition
		initialValueBlock: [ :anInstance | anInstance class  defaultInstance ]; 
		yourself
]

{ #category : #'slot definitions' }
LcsSingletonCode class >> labelSlotDefinition [
	<slotDefinition>
	^ LcsSingletonLabelSlot new
]
